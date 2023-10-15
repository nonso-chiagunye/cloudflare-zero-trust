//This sets the DNS Endpoints that resources are mapped to
resource "cloudflare_teams_location" "staging_dns_location" {
  account_id     = var.account_id
  name           = "${var.locationName}"
  client_default = var.locationName == "HeadOffice" ? true : false
  
// DNS IPs
  networks {
    network = var.dns_ip_1
  }

  networks {
    network = var.dns_ip_2
  }
}