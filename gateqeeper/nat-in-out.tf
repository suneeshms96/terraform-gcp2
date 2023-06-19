# # Create VPC network
# resource "google_compute_network" "vpc_network" {
#   provider                = google-beta
#   name                    = "my-vpc"
#   project                 = var.project_id
#   routing_mode            = var.routing_mode
#   auto_create_subnetworks = false
# }

# # Create subnet
# resource "google_compute_subnetwork" "subnet" {
#   name          = "my-subnet"
#   region        = var.region
#   ip_cidr_range = "10.0.1.0/24"
#   private_ip_google_access = "true"
#   network       = google_compute_network.vpc_network.self_link
# }

# resource "google_compute_router" "router" {
#   name    = "router"
#   network = google_compute_network.vpc_network.self_link

#   bgp {
#     asn       = 64514
#     advertise_mode = "CUSTOM"
#     advertised_groups = ["ALL_SUBNETS"]
#     # advertised_ip_ranges = ["10.0.0.0/16"]
#     advertised_ip_ranges {
#       range = "10.0.0.0/16"
#     }
#   }
# }

# # Create a static NAT IP address
# resource "google_compute_address" "my_nat_ip" {
#   name = "my-nat-ip"
# }

# # Export the NAT IP address
# output "my_nat_ip" {
#   value = google_compute_address.my_nat_ip.address
# }

# resource "google_compute_router_nat" "cloud_nat" {
#   name                    = "cloud-nat"
#   router                  = google_compute_router.router.name
  
#   region                  = var.region
#   nat_ip_allocate_option  = "AUTO_ONLY"
#   source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"
  
#   subnetwork {
#     name                      = "my-subnet"
#     source_ip_ranges_to_nat   = ["10.0.1.0/24"]
#   }

#   log_config {
#     enable = true
#     filter = "ERRORS_ONLY"
#   }
  
# }

# resource "google_compute_firewall" "allow_http" {
#   name    = "arch-allow-http"
#   network = "my-vpc"
#   target_tags = ["vm"]
#   allow {
#     protocol = "tcp"
#     ports    = ["80"]
#   }

#   source_ranges = ["0.0.0.0/0"]
# }

# resource "google_compute_firewall" "allow_nat" {
#   name    = "arch-allow-nat"
#   network = "my-vpc"
#   target_tags = ["vm"]
#   allow {
#     protocol = "icmp"
#   }

#   allow {
#     protocol = "tcp"
#     ports    = ["22"]
#   }

#   allow {
#     protocol = "tcp"
#     ports    = ["80"]
#     # source_ranges = [google_compute_address.nat_ip.address]
#   }
#   direction = "INGRESS"
#   source_ranges = [google_compute_address.my_nat_ip.address]
# }

# # Create a web server instance
# resource "google_compute_instance" "nat_server" {
#   name         = "nat-server"
#   machine_type = "f1-micro"
#   zone         = "us-central1-a"
#   tags = ["vm"]
#   boot_disk {
#     initialize_params {
#       image = "debian-cloud/debian-10"
#     }
#   }

#   network_interface {
#     subnetwork = google_compute_subnetwork.subnet.self_link

#     access_config {
#       nat_ip = google_compute_address.my_nat_ip.address
#     }
#   }

#   metadata_startup_script = <<-EOF
#     #!/bin/bash
#     apt-get update
#     apt-get install -y nginx

#     cat << 'NGINX_CONF' > /etc/nginx/sites-enabled/default
#     server {
#         listen 80;
#         server_name 35.224.35.250;

#         location / {
#             proxy_pass http://192.168.1.7:80;
#             proxy_set_header Host $host;
#             proxy_set_header X-Real-IP $remote_addr;
#         }
#     }
#     NGINX_CONF

#     systemctl restart nginx
#   EOF
# }

# # Create a web server instance
# resource "google_compute_instance" "web_server" {
#   name         = "web-server-1"
#   machine_type = "f1-micro"
#   zone         = "us-central1-a"
#   tags = [ "vm" ]
#   boot_disk {
#     initialize_params {
#       image = "debian-cloud/debian-10"
#     }
#   }

#   network_interface {
#     subnetwork = google_compute_subnetwork.subnet.self_link

#   }

#   metadata_startup_script = <<-EOF
#     #! /bin/bash
#     apt-get update
#     apt-get install -y nginx
#     service nginx start
#     sed -i -- 's/nginx/Google Cloud Platform - '"$HOSTNAME"'/' /var/www/html/index.html
#   EOF
# }




