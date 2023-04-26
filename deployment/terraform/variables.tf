data "http" "MY_IP" {
  url = "https://ipv4.icanhazip.com"
}

variable "AWS_AVAILABILITY_ZONES" {
  description = "Availability zones"
  type        = list(string)
  default     = ["us-west-2b", "us-west-2c"]
}

variable "AWS_DB_PASSWORD_DJANGO_BOILERPLATE" {
  description = "Password of the 'Django Boilerplate' DB"
  type        = string
  sensitive   = true
}
