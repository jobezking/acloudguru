resource "google_storage_bucket" "bucket0" {
  name     = "terraform-gcp-77-bucket0"
  location = var.location
}

resource "google_storage_bucket_object" "general_folder-gcp-77" {
  name    = "terraform-state/"
  content = "placeholder"
  bucket  = google_storage_bucket.bucket0.name
}