terraform {
  #backend "local" {}
  backend "gcs" {
    bucket      = "terraform-gcp-77-bucket"
    prefix      = "terraform-state"
    credentials = "/home/jeking/Desktop/terraform-auth/terraform-gcp-77.json"
  }
}

resource "google_storage_bucket" "bucket" {
  name     = "terraform-gcp-77-bucket"
  location = var.location
}

resource "google_storage_bucket_object" "general_folder" {
  name    = "terraform-state/"
  content = "placeholder"
  bucket  = google_storage_bucket.bucket.name
}

resource "google_compute_network" "vpc_network" {
  name = "terraform-network"
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

resource "google_compute_address" "vm_static_ip" {
  name = "terraform-static-ip"
}