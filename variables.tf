

variable "USER_EMAIL" {
    type = string
    default = ""  
}

variable "API_KEY" {
    type = string
    sensitive = true  
}

variable "account_id" {
    type = string
    default = ""  
}

variable "zone_id" {
    type = string
    default = ""  
}

variable "sourceIP" {
    type = string
    default = ""  
}

variable "devicePostureConfig" {
    type = string
    default = ""  
}

variable "groupEmail" {
    type = string
    default = ""  
}

variable "egressIPV4" {
    type = string
    default = ""  
}

variable "egressIPV6" {
    type = string
    default = ""  
}

variable "locationName" {
    type = string
    default = ""  
}

variable "allowed_idps" {
    type = list(set)
    default = [ "" ]  
}

variable "access_policy_name" {
    type = string
    default = ""  
}

variable "idp_id" {
    type = string
    default = ""  
}

variable "idp_name" {
    type = list(string)
    default = [ "" ]  
}

variable "required_ip_list" {
    type = list(string)
    default = [ "" ]  
}

variable "access_group_name" {
    type = string
    default = ""  
}

variable "access_token" {
    type = string
    default = ""  
}

variable "device_policy_name" {
    type = string
    default = ""  
}

variable "device_policy_description" {
    type = string
    default = ""  
}

variable "captive_portal" {
    type = number
    default = ""  
}

variable "device_posture_rule" {
    type = string
    default = ""  
}

variable "posture_rule_type" {
    type = string
    default = ""  
}

variable "posture_rule_description" {
    type = string
    default = ""  
}

variable "os_platform" {
    type = string
    default = "linux"  
}

variable "os_version" {
    type = string
    default = ""  
}

variable "os_distro_name" {
    type = string
    default = "ubuntu"  
}

variable "dns_ip_1" {
    type = string
    default = ""  
}

variable "dns_ip_2" {
    type = string
    default = ""  
}

variable "teams_dns_rule_name" {
    type = string
    default = ""  
}

variable "teams_dns_rule_description" {
    type = string
    default = ""  
}

variable "dns_block_list" {
    type = list(number)
    default = [  ]  
}

variable "teams_egress_policy" {
    type = string
    default = ""  
}

variable "teams_egress_policy_description" {
    type = string
    default = ""  
}

variable "footer_text" {
    type = string
    default = ""  
}

variable "header_text" {
    type = string
    default = ""  
}

variable "logo_path" {
    type = string
    default = ""  
}

variable "background_color" {
    type = string
    default = ""  
}

variable "teams_list_name" {
    type = string
    default = ""  
}

variable "teams_list_description" {
    type = string
    default = ""  
}

variable "teams_list_items" {
    type = list(string)
    default = [ "" ]  
}

variable "tunnel_name" {
    type = string
    default = ""  
}

variable "tunnel_password" {
    type = string
    sensitive = true  
}

variable "connect_timeout" {
    type = string
    default = ""  
}

variable "tls_timeout" {
    type = string
    default = ""  
}

variable "tcp_keep_alive" {
    type = string
    default = ""  
}

variable "keep_alive_connections" {
    type = string
    default = ""  
}

variable "keep_alive_timeout" {
    type = string
    default = ""  
}

variable "http_host_header" {
    type = string
    default = ""  
}

variable "origin_server_name" {
    type = string
    default = ""  
}

variable "ca_pool" {
    type = string
    default = ""  
}

variable "proxy_address" {
    type = string
    default = ""  
}

variable "proxy_port" {
    type = string
    default = ""  
}

variable "proxy_type" {
    type = string
    default = ""  
}

variable "ingress_rule1_hostname" {
    type = string
    default = ""  
}

variable "ingress_rule1_path" {
    type = string
    default = ""  
}

variable "ingress_rule1_service" {
    type = string
    default = ""  
}

variable "ingress_rule1_connect_timeout" {
    type = string
    default = ""  
}

variable "ingress_rule1_team_name" {
    type = string
    default = ""  
}

variable "ingress_rule1_audience_tag" {
    type = list(string)
    default = [ "" ]   
}

variable "ingress_rule2_service" {
    type = string
    default = ""      
}




