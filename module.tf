# github.com/GoogleCloudPlatform/cloud-foundation-fabric/tree/master/modules

module "network" {
  source     = "./modules/net-vpc"
  name = "my-vpc-network"
  project_id   = var.project

  subnets = [
    {
      name   = "subnet-01"
      ip_cidr_range     = var.cidr
      region = var.region
      secondary_ip_range = {}
    },
  ]
}

module "network_fabric-net-firewall" {
  source = "./modules/net-vpc-firewall"
  project_id              = var.project
  network                 = module.network.name
  admin_ranges            = var.cidr

}