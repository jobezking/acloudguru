terraform {
  #backend "local" {} store backend in GCP bucket instead
  backend "gcs" {
    bucket      = "terraform-gcp-77-bucket"
    prefix      = "terraform-state"
    credentials = "/home/jeking/Desktop/terraform-auth/terraform-gcp-77.json"
  }
}

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
  }
}


resource "google_compute_instance" "vm_instance-micro" {
    name = "terraform-instance-micro"
    machine_type = "f1-micro"
    boot_disk {
        initialize_params {
          image = "debian-cloud/debian-11"
        }
    }

    network_interface {
      network = google_compute_network.vpc_network.name
      access_config {

      }
    }
}

resource "google_compute_instance" "vm_instance-module" {
    name = "terraform-instance-module"
    machine_type = "f1-micro"
    boot_disk {
        initialize_params {
          image = "debian-cloud/debian-11"
        }
    }

    network_interface {
      network = module.network.name
      access_config {

      }
    }
}