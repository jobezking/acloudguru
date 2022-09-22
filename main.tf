
resource "google_compute_instance" "vm_instance" {
  name         = "terraform-instance"
  machine_type = var.arm-machine-type
  zone         = var.zone
  boot_disk {
    initialize_params {
      image = var.arm-image
    }
  }
  network_interface {
    network = google_compute_network.vpc_network.name
    access_config {
      nat_ip = ""
    }
  }
  allow_stopping_for_update = true
  metadata_startup_script   = file("./src/startup.sh")
}


resource "google_compute_instance" "vm_instance-micro" {
  name         = "terraform-instance-micro"
  machine_type = "f1-micro"
  tags         = ["web"]
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    network = google_compute_network.vpc_network.name
    access_config {
      nat_ip = ""
    }
  }
  allow_stopping_for_update = true
  metadata_startup_script   = file("./src/install-chrome-remote-desktop.sh")
}

module "vm_instance-module" {
  source     = "./modules/compute-vm"
  name       = "terraform-instance-module"
  zone       = var.zone
  project_id = var.project
  tags       = ["web"]
  boot_disk = {
    image = "debian-cloud/debian-11"
    type  = "pd-ssd"
    size  = 10
  }

  network_interfaces = [{
    network    = module.vpc.network_self_link
    subnetwork = module.vpc.subnets_self_links[0]
    nat        = false
    addresses  = null
  }]
  options = {
    allow_stopping_for_update = true
    deletion_protection       = false
    spot                      = false
    termination_action        = "STOP"
  }
  metadata = {
    metadata_startup_script = file("./src/startup.sh")
  }
}