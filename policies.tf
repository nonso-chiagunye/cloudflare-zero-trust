// Create DNS policies to filter users DNS queries. All DNS queries are evaluated against these policy criteria
resource "cloudflare_teams_rule" "staging_dns_policy" {
  account_id  = var.account_id
  name        = var.teams_dns_rule_name
  description = var.teams_dns_rule_description
  precedence  = 1
  action      = "block"
  traffic     = "any(dns.security_category[*] in {${var.dns_block_list}})" // Block traffic that falls in the specified security category - (see https://developers.cloudflare.com/cloudflare-one/policies/gateway/domain-categories/)
  rule_settings {
    block_page_enabled = true
    block_page_reason  = "Failed Policy Check"
  }
}

// Create Network policies to filter traffic based on the policy criterias
resource "cloudflare_teams_rule" "staging_network_policy" {
    for_each = { for network in local.networks : network.numb => network }
  enabled     = true
  name        = "${each.value.name}"
  account_id  = var.account_id
  description = "${each.value.description}"
  precedence  = 1
  action      = "allow"
  traffic     = "net.dst.ip in { ${each.value.cidr} }"  // List of subnet IPs
  identity    = "any(identity.groups.name[*] in {\"${each.value.ou1}\"}) || any(identity.groups.name[*] in {\"${each.value.ou2}\"})" // Identity match criterias to allow access

}

// Creates http policies that filter http traffic based on the specified policy conditions
resource "cloudflare_teams_rule" "staging_http_policy" {
  for_each = {for domain in local.domains : domain.numb => domain}
  account_id  = var.account_id
  name        = "${each.value.name}"
  description = "${each.value.description}"
  precedence  = 1
  action      = "allow"
  filters     = ["http"]
  traffic     = "any(http.request.domains[*] in {\".${each.value.domain}\"})"
  identity = "any(identity.email[*] in {\"@${each.value.domain}\"})"
  rule_settings {
    block_page_enabled = true
    block_page_reason  = "Failed Policy Check"
  }
}

// Egress policies specify which IP can egress based on set criterias like identity, IP addresses, network, and geolocation attributes.
resource "cloudflare_teams_rule" "staging_egress_policy" {
  account_id  = var.account_id
  name        = var.teams_egress_policy
  description = var.teams_egress_policy_description
  precedence  = 1
  action      = "allow"
  filters     = ["http"]
  traffic     = "net.src.ip == \"${var.sourceIP}\""
  identity    = "identity.groups.id == \"${var.groupEmail}\""
  device_posture = "any(device_posture.checks.failed[*] in {\"${var.devicePostureConfig}\"})"
  rule_settings {
    egress {   // Dedicated Cloudflare Egress IPs
      ipv4 = "${var.egressIPV4}"
      ipv6 = "${var.egressIPV6}"
    }
  }
}



