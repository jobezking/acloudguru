terraform {
  #backend "local" {} store backend in GCP bucket instead
  backend "gcs" {
    bucket      = "terraform-gcp-77-bucket"
    prefix      = "terraform-state"
    credentials = "/home/jeking/Desktop/terraform-auth/terraform-gcp-77.json"
  }
}