# resource "google_compute_firewall" "firewall-rule" {
#   name       = "firewall-rule"
#   network = google_compute_network.my-vpc.self_link
#   priority   = 1000
#   direction  = "INGRESS"
  
#   # Update source ranges, source tags, and target tags as needed
#   source_ranges = [
#     "34.171.218.201/32",
#     "35.238.137.5/32",
#     # Add more IP ranges as needed
#   ]

#   target_tags = [
#     "gateqeeper",
#     "https",
#     "http"
#     # Add more target tags as needed
#   ]

#   allow {
#     protocol = "tcp"
#     ports    = ["22", "443", "8080", "7777", "5090", "5061", "8083", "8088", "8883", "8000", "8080", "8089", "6379", "3306", "1883", "3000", "443", "80", "9000"]
#   }

#   allow {
#     protocol = "udp"
#     ports    = ["5000-60000"]
#   }

#   log_config {
#     metadata = "INCLUDE_ALL_METADATA"
#   }
#   depends_on = [
#     google_compute_network.my-vpc
#   ]

# }
