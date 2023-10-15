// Defines the base configurations for the secure web Gateway
resource "cloudflare_teams_account" "staging_teams_account" {
  account_id                 = var.account_id
  tls_decrypt_enabled        = true
  protocol_detection_enabled = true

  block_page {
    footer_text      = var.footer_text
    header_text      = var.header_text
    logo_path        = var.logo_path
    background_color = var.background_color      
  }

  antivirus {
    enabled_download_phase = true
    enabled_upload_phase   = false
    fail_closed            = true
  }

 
  proxy {
    tcp     = true
    udp     = true
    root_ca = true
  }

  url_browser_isolation_enabled = true

  logging {
    redact_pii = true
    settings_by_rule_type {
      dns {
        log_all    = false
        log_blocks = true
      }
      http {
        log_all    = true
        log_blocks = true
      }
      l4 {
        log_all    = false
        log_blocks = true
      }
    }
  }
}

// Defines teams list, that's referenced while creating Secure Web gateways
resource "cloudflare_teams_list" "staging_teams_list" {
  account_id  = var.account_id
  name        = var.teams_list_name
  type        = "IP"
  description = var.teams_list_description
  items       = var.teams_list_items                
}