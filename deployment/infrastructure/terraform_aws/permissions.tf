# SSH to EC2 CLOUD ATLAS BLOG
resource "tls_private_key" "django_boilerplate_private_ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_sensitive_file" "django_boilerplate_private_ssh_key" {
  filename             = pathexpand("~/.ssh/django_boilerplate_private_ssh_key.pem")
  file_permission      = "600"
  directory_permission = "700"
  content              = tls_private_key.django_boilerplate_private_ssh_key.private_key_pem
}

resource "aws_key_pair" "django_boilerplate_private_ssh_key_pair" {
  key_name   = "django_boilerplate_backend_private_ssh_key"
  public_key = tls_private_key.django_boilerplate_private_ssh_key.public_key_openssh
  tags = {
    Name = "Django BoilerplateBackend"
  }
}
