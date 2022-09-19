output "ip" {
  value = google_compute_address.vm_static_ip.address
}

output "vm_instance_ip" {
  value = google_compute_instance.vm_instance.network_interface.0.network_ip
}

output "vm_instance-micro_ip" {
  value = google_compute_instance.vm_instance-micro.network_interface.0.network_ip
}

output "vm_instance-module" {
  value = google_compute_instance.vm_instance-module.network_interface.0.network_ip
}