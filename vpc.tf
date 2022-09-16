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

module "network" {
  source     = "./modules/net-vpc"
  name       = "my-vpc-network"
  project_id = var.project

  subnets = [
    {
      name               = "subnet-01"
      ip_cidr_range      = var.cidr
      region             = var.region
      secondary_ip_range = {}
    },
    {
      name               = "subnet-02"
      ip_cidr_range      = var.cidrsub
      region             = var.region
      secondary_ip_range = {}
    },
  ]
}

module "network_fabric-net-firewall" {
  source       = "./modules/net-vpc-firewall"
  project_id   = var.project
  network      = module.network.name
  admin_ranges = var.cidr_range

}