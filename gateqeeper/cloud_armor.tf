# resource "google_compute_security_policy" "cloud-armor-policy" {
#   name    = "cloud-armor-policy-${var.env_name}"
#   project = var.project_id

#     #blacklist traffic from certain ip address
#   rule {
#     action   = "deny(403)"
#     priority = "1000"
#     match {
#       versioned_expr = "SRC_IPS_V1"
#       config {
#         src_ip_ranges = ["103.126.7.151/32"]
#       }
#     }
#     description = "Deny access to IPs in 103.126.7.151/32"
#   }

#   #Allow access to all IP (default rule)
#   rule {
#     action   = "allow"
#     priority = "2147483647"
#     match {
#       versioned_expr = "SRC_IPS_V1"
#       config {
#         src_ip_ranges = ["*"]
#       }
#     }
#     description = "default rule"
#   }

#   #rate based ban
#   rule {
#     action = "rate_based_ban"
#     preview = true
#     priority = "1002"
#     match {
#       versioned_expr = "SRC_IPS_V1"
#       config {
#         src_ip_ranges = ["*"]
#       }
#     }
#     rate_limit_options {
#       conform_action = "allow"
#       exceed_action = "deny(403)"
#       ban_duration_sec = 60
#       rate_limit_threshold {
#         count = 10
#         interval_sec = 60
#       }
#     }
#   } 
# }








