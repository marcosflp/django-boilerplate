terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
    godaddy = {
      source  = "n3integration/godaddy"
      version = "~> 1.9.1"
    }
  }
}

provider "digitalocean" {
  token = var.DIGITALOCEAN_TOKEN
}

provider "godaddy" {}

resource "digitalocean_droplet" "django_boilerplate_backend" {
  image = "ubuntu-20-04-x64"
  name = "django_boilerplate-backend"
  region = "nyc3"
  size = "s-1vcpu-1gb"
  ssh_keys = [
    digitalocean_ssh_key.digitalocean_django_boilerplate_public_ssh_key.fingerprint
  ]
}

# OUTPUTS

output "droplet_ip_address" {
  description = "Public IP address of the Droplet instance"
  value       = digitalocean_droplet.django_boilerplate_backend.ipv4_address
}

output "project_ssh_key" {
  description = "A new key was generated on ~/.ssh/ to access the EC2 with SSH"
  value       = "Saved at ${local_sensitive_file.digitalocean_django_boilerplate_public_ssh_key.filename}"
}
