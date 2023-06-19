# resource "google_compute_instance" "vm-instance" {
#     name = "terraform-vm"
#     machine_type = "f1-micro"
#     zone = "us-central1-a"
#     tags = [ "vm" ]
#     boot_disk {
#       initialize_params {
#         image = "debian-cloud/debian-11"
#       }
#     }
#     network_interface {
#       network = google_compute_network.my-vpc.self_link
#       subnetwork = google_compute_subnetwork.private-subnet.self_link

#       # access_config {
#       #   nat_ip = google_compute_address.internal-nat.ip_cidr_range
#       # }
#     }
# }



# resource "google_compute_firewall" "ssh" {
#   name        = "allow-ssh"
#   network     = google_compute_network.my-vpc.self_link
#   direction   = "INGRESS"
#   priority    = 1000

#   source_ranges = ["0.0.0.0/0"]
#   target_tags   = ["vm"]

#   allow {
#     protocol = "tcp"
#     ports    = ["22"]
#   }
#   depends_on = [
#     google_compute_network.my-vpc
#   ]
# }

