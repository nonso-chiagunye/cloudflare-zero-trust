terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4.0"
    }
  }
}

provider "cloudflare" {
  email = var.USER_EMAIL   // or export CLOUDFLARE_EMAIL=your@example.com 
  api_key = var.API_KEY    // or export CLOUDFLARE_TOKEN=your-api-key
}

locals {
  networks = csvdecode(file("files/networks.csv"))
  apps = csvdecode(file("files/apps.csv"))
  domains = csvdecode(file("files/domains.csv"))
  tunnels = csvdecode(file("files/tunnels.csv"))
}


