resource "tls_private_key" "digitalocean_django_boilerplate_private_ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_sensitive_file" "digitalocean_django_boilerplate_private_ssh_key" {
  filename             = pathexpand("~/.ssh/digitalocean_django_boilerplate_private_ssh_key.pem")
  file_permission      = "600"
  directory_permission = "700"
  content              = tls_private_key.digitalocean_django_boilerplate_private_ssh_key.private_key_pem
}

resource "local_sensitive_file" "digitalocean_django_boilerplate_public_ssh_key" {
  filename             = pathexpand("~/.ssh/digitalocean_django_boilerplate_public_ssh_key.pem")
  file_permission      = "600"
  directory_permission = "700"
  content              = tls_private_key.digitalocean_django_boilerplate_private_ssh_key.public_key_openssh
}

resource "digitalocean_ssh_key" "digitalocean_django_boilerplate_public_ssh_key" {
  name = "terraform"
  public_key = local_sensitive_file.digitalocean_django_boilerplate_public_ssh_key.content
}
