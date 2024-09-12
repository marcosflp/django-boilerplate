variable "VPN_IP_ADDRESS" {
  description = "My dedicated VPN IP address"
  type        = string
  default     = "181.214.9.86/32"
}
data "http" "MY_IP" {
  url = "https://ipv4.icanhazip.com"
}

variable "AWS_DEFAULT_ZONE" {
  description = "Availability zones"
  type        = string
  default     = "sa-east-1"
}

variable "AWS_DEFAULT_AVAILABILITY_ZONES" {
  description = "Availability zones"
  type        = list(string)
  default     = ["sa-east-1a", "sa-east-1b"]
}

variable "AWS_DB_PASSWORD_DJANGO_BOILERPLATE" {
  description = "Password of the Django BoilerplateDB"
  type        = string
  sensitive   = true
}
