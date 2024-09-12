resource "godaddy_domain_record" "godaddy_django_boilerplate" {
  domain = "django_boilerplate.com"

  record {
    name     = "@"
    type     = "A"
    data     = digitalocean_droplet.django_boilerplate_backend.ipv4_address
    ttl      = 600
    priority = 0
  }

  record {
    name     = "www"
    type     = "CNAME"
    data     = "@"
    ttl      = 3600
    priority = 0
  }
}
