// Sets the application(s) you want to restrict access to using Cloudflare Zero Trust Policies
resource "cloudflare_access_application" "staging_app" {
  for_each = {for app in local.apps : app.numb => app}
  zone_id          = var.zone_id
  name             = "${each.value.name}"
  domain           = "${each.value.domain}"
  type             = "${each.value.type}"   // can be Self-hosted, SaaS, etc.
  session_duration = "24h"
  allowed_idps = var.allowed_idps  //The Identity Provider(s) that can be the Source of Truth for access to the applications
  auto_redirect_to_identity = length(var.allowed_idps) > 1 ? false : true  //If you set only one IdP, then this becomes true - users will be automatically redirected to that IdP
  app_launcher_visible = true 
  http_only_cookie_attribute = true 
}

// Policies to restrict access to the applications
resource "cloudflare_access_policy" "staging_app_policy" {
  application_id = cloudflare_access_application.staging_app.id 
  zone_id        = var.zone_id
  name           = var.access_policy_name
  precedence     = "1"
  decision       = "allow"


  include {  // List of access conditions (compulsory). It can be email, IPs, Domains,IdP (eg Okta), cloud service like Azure etc
    okta {
      identity_provider_id = var.idp_id
      name = var.idp_name 
    }
  }

  require {  // Optional access conditions that are required.
    ip_list = var.required_ip_list
  }
}

// Restrict access based on a directory Group Membership. You can grant access to both applications and networks based on access groups
resource "cloudflare_access_group" "staging_group" {
  account_id = var.account_id
  name       = var.access_group_name 

  include {  // List of access conditions (compulsory). It can be email, IPs, Domains,IdP (eg Okta), cloud service like Azure etc
    okta {
      identity_provider_id = var.idp_id
      name = var.idp_name
    }
  }
}

// Token required for services to communicate with an application that is behind Cloudflare access
resource "cloudflare_access_service_token" "staging_service_token" {
  account_id = var.account_id
  name       = var.access_token
  duration = "8760h"

  min_days_for_renewal = 30

  # This flag is important to set if min_days_for_renewal is defined otherwise
  # there will be a brief period where the service relying on that token
  # will not have access due to the resource being deleted

}