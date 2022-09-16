variable "project" {
  default = "terraform-gcp-77"
}

variable "credentials_file" {
  default = "/home/jeking/Desktop/terraform-auth/terraform-gcp-77.json"
}

variable "region" {
  default = "us-central1"
}

variable "location" {
  default = "us-central1"
}

variable "zone" {
  default = "us-central1-f"
}

variable "arm-image" {
  default = "debian-cloud/debian-11-bullseye-arm64-v20220719"
}

variable "arm-machine-type" {
  default = "t2a-standard-1"
}

variable "google-cidr" {
  default = "192.168.0.0/16"
}

variable "google-cidrsub" {
  default = "192.168.0.0/16"
}

variable google-cidr_range{
  
}

variable "cidr" {
  default = "10.0.0.0/16"
}

variable "cidrsub" {
  default = "10.0.0.0/16"
}

