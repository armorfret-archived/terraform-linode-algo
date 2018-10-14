output "ip_address" {
  value       = "${module.vm.ip_address}"
  description = "Public IP of the Linode"
}
