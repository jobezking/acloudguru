terraform {
  required_version = ">= 1.0.0"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 4.0.0"
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = ">= 4.0.0"
    }
  }
}

provider "google" {
  credentials = file(var.credentials_file)
  project     = var.project
  region      = var.region
  zone        = var.zone
}

provider "google-beta" {
  credentials = file(var.credentials_file)
  project     = var.project
  region      = var.region
  zone        = var.zone
}

terraform {
  #backend "local" {} store backend in GCP bucket instead
  backend "gcs" {
    bucket      = "terraform-gcp-77-bucket"
    prefix      = "terraform-state"
    credentials = "/home/jeking/Desktop/terraform-auth/terraform-gcp-77.json"
  }
}
