resource "google_compute_network" "my-vpc" {
  provider = google-beta
  name               = "terraform-vpc"
  project            = var.project_id
  routing_mode       = var.routing_mode
  auto_create_subnetworks = false
}

# private subnet in the VPC
resource "google_compute_subnetwork" "private-subnet" {
  name          = "terraform-private-subnet"
  project       = var.project_id
  ip_cidr_range = "10.5.0.0/16"
  region        = var.region
  private_ip_google_access = "true"
  network       = google_compute_network.my-vpc.id
  secondary_ip_range = [
    {
      range_name    = "k8s-pod-range"
      ip_cidr_range = "192.168.0.0/16"
    },
    {
      range_name    = "k8s-service-range"
      ip_cidr_range = "192.169.0.0/18"
    }
  ]
}

resource "google_compute_subnetwork" "public-subnet" {
  name          = "terraform-public-subnet"
  project       = var.project_id
  ip_cidr_range = "10.6.0.0/16"
  network       = google_compute_network.my-vpc.id
  region        = var.region
  secondary_ip_range = [
    {
      range_name    = "k8s-pod-range-public"
      ip_cidr_range = "192.166.0.0/16"
    },
    {
      range_name    = "k8s-service-range-public"
      ip_cidr_range = "192.167.0.0/18"
    }
  ]
}

resource "google_compute_router" "router" {
  name    = "terraform-router-1"
  region  = google_compute_subnetwork.private-subnet.region
  network = google_compute_network.my-vpc.id
  project = var.project_id
  depends_on = [
    google_compute_network.my-vpc
  ]
}

resource "google_compute_router_nat" "cloud-router-nat" {
  name                               = "cloud-router-nat"
  router                             = google_compute_router.router.name
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
  project                            = var.project_id
  region                             = var.region
  depends_on = [
    google_compute_global_address.private_ip_address
  ]
}

resource "google_compute_global_address" "private_ip_address" {
    project         = var.project_id
    name            = "ip-for-nat"
    purpose         = "VPC_PEERING"
    address_type    = "INTERNAL"
    ip_version      = "IPV4"
    prefix_length   = 24
    network         = google_compute_network.my-vpc.id
}
###################################
resource "google_service_networking_connection" "private_vpc_connection" {
    network         = google_compute_network.my-vpc.id
    service         = "servicenetworking.googleapis.com"
    reserved_peering_ranges = [google_compute_global_address.private_ip_address.name]
    depends_on = [
      google_compute_global_address.private_ip_address
    ]
}