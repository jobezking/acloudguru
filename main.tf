
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

resource "google_compute_instance" "vm_instance-module" {
  name         = "terraform-instance-module"
  machine_type = "f1-micro"
  tags         = ["web"]
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    #network = var.module_network
    network = "default"
    access_config {
      nat_ip = ""
    }
  }
  allow_stopping_for_update = true
  metadata_startup_script   = file("./src/startup.sh")
}