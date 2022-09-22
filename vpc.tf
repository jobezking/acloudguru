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
    source  = "terraform-google-modules/network/google"
    version = "~> 4.0"

    project_id   = var.project
    network_name = var.module_vpc
    routing_mode = "GLOBAL"

    subnets = [
    {
      subnet_name   = "subnet-01"
      subnet_ip     = var.module_ranges[0]
      subnet_region = var.region
    },
    {
      subnet_name           = "subnet-02"
      subnet_ip             = var.module_ranges[1]
      subnet_region         = var.region
      google_private_access = true
    },
    {
      subnet_name   = "subnet-03"
      subnet_ip     = var.module_ranges[2]
      subnet_region = var.region
    },
    {
      subnet_name   = "subnet-04"
      subnet_ip     = var.module_ranges[3]
      subnet_region = var.region
    },
  ]
  secondary_ranges = {
    subnet-01 = [
      {
        range_name    = "subnet-01-secondary-01"
        ip_cidr_range = "192.168.64.0/24"
      },
    ]

    subnet-02 = []
  }

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

module "network_fabric-net-firewall" {
  source     = "./modules/net-vpc-firewall"
  project_id = var.project
  network    = module.vpc.network_name
  #admin_ranges = var.cidr_range

}

# module "network_routes" {
#   source = "./modules/routes"

#   network_name = module.vpc.network_name
#   project_id   = var.project

#   routes = [
#     {
#       name              = "egress-internet"
#       description       = "route through IGW to access internet"
#       destination_range = "0.0.0.0/0"
#       tags              = "egress-inet"
#       next_hop_internet = "true"
#     },

#   ]
#}