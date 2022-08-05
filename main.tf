terraform {
  #backend "local" {}
  backend "gcs" {
    bucket = "terraform-gcp-77-bucket"
    prefix = "terraform-state"
    credentials = "/home/jeking/Desktop/terraform-auth/terraform-gcp-77.json"
  }
}

resource "google_storage_bucket" "bucket" {
  name = "terraform-gcp-77-bucket"
  location = var.location
}

resource "google_storage_bucket_object" "general_folder" {
  name = "terraform-state/"
  content = "placeholder"
  bucket = "${google_storage_bucket.bucket.name}"
}

resource "google_compute_network" "vpc_network" {
  name="terraform-network"
}