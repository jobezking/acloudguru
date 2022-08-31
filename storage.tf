resource "google_storage_bucket" "bucket" {
  name     = "terraform-gcp-77-bucket"
  location = var.location
}

resource "google_storage_bucket_object" "general_folder" {
  name    = "terraform-state/"
  content = "placeholder"
  bucket  = google_storage_bucket.bucket.name
}