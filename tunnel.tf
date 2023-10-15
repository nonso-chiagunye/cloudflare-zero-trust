
// Tunnels create secure connection between Cloudflare and your private infrastructure
resource "cloudflare_tunnel" "staging_tunnel" {
  account_id = var.account_id
  name       = var.tunnel_name 
  secret     = var.tunnel_password       
}

// Configuration and ingress rules for Cloudflare tunnels
resource "cloudflare_tunnel_config" "staging_tunnel_config" {
  account_id = var.account_id
  tunnel_id  = cloudflare_tunnel.staging_tunnel.id

  config {
    warp_routing {
      enabled = true
    }
    origin_request {
      connect_timeout          = var.connect_timeout  // "1m0s"
      tls_timeout              = var.tls_timeout      // "1m0s"
      tcp_keep_alive           = var.tcp_keep_alive   // "1m0s"
      no_happy_eyeballs        = false
      keep_alive_connections   = var.keep_alive_connections  //  1024
      keep_alive_timeout       = var.keep_alive_timeout   // "1m0s"
      http_host_header         = var.http_host_header     //  "baz"
      origin_server_name       = var.origin_server_name    //  "foobar"
      ca_pool                  = var.ca_pool        //  "/path/to/unsigned/ca/pool"
      no_tls_verify            = false
      disable_chunked_encoding = false
      bastion_mode             = false
      proxy_address            = var.proxy_address  // "10.0.0.1"
      proxy_port               = var.proxy_port   //   "8123"
      proxy_type               = var.proxy_type  // "socks"
      ip_rules {
        prefix = "/web"
        ports  = [80, 443]
        allow  = true
      }
    }
    ingress_rule {
      hostname = var.ingress_rule1_hostname // "foo"
      path     = var.ingress_rule1_path   // "/bar"
      service  = var.ingress_rule1_service // "http://10.0.0.2:8080"
      origin_request {
        connect_timeout = var.ingress_rule1_connect_timeout  // "2m0s"
        access {
          required  = true
          team_name =  var.ingress_rule1_team_name  // "terraform"
          aud_tag   =  var.ingress_rule1_audience_tag // ["AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"]
        }
      }
    }
    ingress_rule {
      service =  var.ingress_rule2_service   // "https://10.0.0.3:8081"
    }
  }
}

// Routes used to direct IP traffic through Cloudflare tunnel
resource "cloudflare_tunnel_route" "jumia-globalops-staging-loop" {
    for_each = { for tunnel in local.tunnels : tunnel.numb => tunnel }
  account_id         = var.account_id
  tunnel_id          = cloudflare_tunnel.staging_tunnel.id
  network            = "${each.value.cidr}"
}