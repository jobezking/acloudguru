resource "google_compute_network" "vpc_network" {
  name = "terraform-network"
}

resource "google_compute_address" "vm_static_ip" {
  name = "terraform-static-ip"
}

resource "google_compute_firewall" "default" {
    name = "test-firewall"
    network = google_compute_network.vpc_network.name
        allow{
            protocol = "icmp"
        }
        allow{
            protocol = "tcp"
            ports = ["80", "8080", "1000-2000"]
        }
        source_tags = ["web"]

}