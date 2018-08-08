output "ip_address" {
  value       = "${linode_instance.algo.ip_address}"
  description = "Public IP of the Linode"
}
