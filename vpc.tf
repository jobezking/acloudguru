resource "google_compute_network" "vpc_network" {
  name = "terraform-network"
}

resource "google_compute_address" "vm_static_ip" {
  name = "terraform-gcp-77-static-ip"
}

resource "google_compute_firewall" "default" {
  name    = "test-firewall"
  network = google_compute_network.vpc_network.name
  allow {
    protocol = "icmp"
  }
  allow {
    protocol = "tcp"
    ports    = ["80", "8080", "1000-2000"]
  }
  source_tags = ["web"]

}

# github.com/GoogleCloudPlatform/cloud-foundation-fabric/tree/master/modules

module "vpc" {
  source = "./modules/vpc"

  auto_create_subnetworks = false
  project_id              = var.project
  network_name            = var.module_network

  shared_vpc_host = false
}

module "network" {
  source = "./modules/subnets"

  network_name = module.vpc.network_name
  project_id   = var.project

  subnets = [
    {
      subnet_name   = "subnet-01"
      subnet_ip     = var.cidr
      subnet_region = var.region
    },
    {
      subnet_name           = "subnet-02"
      subnet_ip             = var.private_cidr
      subnet_region         = var.region
      google_private_access = true
    },
  ]

  secondary_ranges = {
    subnet-01 = []

  }
}

module "network_fabric-net-firewall" {
  source       = "./modules/net-vpc-firewall"
  project_id   = var.project
  network      = module.vpc.network_name
  admin_ranges = var.cidr_range

}

module "network_routes" {
  source = "./modules/routes"

  network_name = module.vpc.network_name
  project_id   = var.project

  routes = [
    {
      name              = "egress-internet"
      description       = "route through IGW to access internet"
      destination_range = "0.0.0.0/0"
      tags              = "egress-inet"
      next_hop_internet = "true"
    },

  ]
}