variable "name" {
  type        = "string"
  description = "The human-readable name for the server. Used when naming the Linode (with a suffix of '-algo')"
}

variable "ssh_keys" {
  type        = "list"
  description = "SSH public keys used to log in as root to the server"
  default     = []
}

variable "users" {
  type        = "list"
  description = "List of authorized users (Linode usernames, must have keys already assigned via Linode API)"
  default     = []
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

variable "algo_repo" {
  type        = "string"
  default     = "https://github.com/akerl/algo"
  description = "Repo to use for Algo code"
}

variable "image_id" {
  type        = "string"
  default     = "linode/ubuntu18.04"
  description = "Source image to build on"
}
