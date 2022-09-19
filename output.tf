output "ip" {
  value = google_compute_address.vm_static_ip.address
}

output "vm_instance_ip" {
  value = google_compute_instance.vm_instance.network_interface.0.network_ip
}

output "vm_instance-micro_ip" {
  value = google_compute_instance.vm_instance-micro.network_interface.0.network_ip
}

output "vm_instance-module_external" {
  value = module.vm_instance-module.external_ip
}

output "vm_instance-module_internal" {
  value = module.vm_instance-module.internal_ip
}