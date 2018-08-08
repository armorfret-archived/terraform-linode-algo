variable "name" {
  type        = "string"
  description = "The human-readable name for the server. Used when naming the Linode (with a suffix of '-algo')"
}

variable "ssh_key" {
  type        = "string"
  description = "SSH public key used to log in as root to the server"
}

variable "region" {
  type        = "string"
  default     = "us-central"
  description = "Region to place the Linode in"
}

variable "type" {
  type        = "string"
  default     = "g6-standard-2"
  description = "Plan type for the Linode"
}

variable "users" {
  type        = "list"
  description = "List of user accounts to provision for VPN access"
}
