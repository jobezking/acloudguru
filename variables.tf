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

variable "apache_startup_script" {
  default = "./src/startup.sh"
}

variable "rdp_startup_script" {
  default = "./src/install-chrome-remote-desktop.sh"
}

variable "arm-machine-type" {
  default = "t2a-standard-1"
}

variable "cidr" {
  default = "10.0.0.0/16"
}

variable "cidr_range" {
  default = ["10.0.0.0/16"]
}

variable "private_cidr" {
  default = "10.0.0.0/16"
}

variable "module_vpc" {
  type    = string
  default = "default_network"
}

variable "module_ranges" {
  description = "Subnets"
  type        = list(string)
  default = [
    "10.2.218.192/26",
    "10.2.218.128/26",
    "10.2.219.0/28",
  "10.2.219.16/28"]
}
