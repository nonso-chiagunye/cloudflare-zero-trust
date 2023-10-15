// Settings for devices that access resources through Cloudflare Warp
resource "cloudflare_device_settings_policy" "staging_warp_policy" {
  account_id            = var.account_id
  name                  = var.device_policy_name
  description           = var.device_policy_description
  precedence            = 1
  // Identity conditions that must be met
  match                 = "any(identity.groups.name[*] in {\"${var.device_policy_name == Staging ? "staging.group" : "production.group"}\"})"
  default               = true 
  enabled               = true
  allow_mode_switch     = true
  allow_updates         = true
  allowed_to_leave      = true
  auto_connect          = 0
  captive_portal        = var.captive_portal
  disable_auto_fallback = true
  support_url           = "https://cloudflare.com"
  switch_locked         = true
  service_mode_v2_mode  = "warp"
  service_mode_v2_port  = 3000
  exclude_office_ips    = false
}

// Sets rule for Device Posture checks. Device posture checks can be based on warp itself, os_version, or third part services like EDR (eg CrowdStrike)
resource "cloudflare_device_posture_rule" "staging_posture_rule" {
  account_id  = var.account_id
  name        = var.device_posture_rule 
  type        = var.posture_rule_type  // Type can be warp itself, os_version, or 3rd party, like CrodStrike
  description = var.posture_rule_description
  schedule    = "24h"
  expiration  = "24h"

// For OS Posture rule type
  match {
    platform = var.os_platform
  }

  input {
    id                 = cloudflare_teams_list.staging_teams_list.id
    version            = var.os_version
    operator           = ">="
    os_distro_name     = var.os_distro_name
    os_distro_revision = var.os_version
  }
}