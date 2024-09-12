variable "VPN_IP_ADDRESS" {
  description = "Marcos's dedicated VPN IP address"
  type        = string
  default     = "181.214.9.86/32"
}

data "http" "MY_IP" {
  url = "https://ipv4.icanhazip.com"
}

variable "DIGITALOCEAN_TOKEN" {
  description = "Digital Ocean Authentication Token"
  type        = string
}
