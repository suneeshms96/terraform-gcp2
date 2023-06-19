resource "google_container_cluster" "cluster1" {
  name               = "terraform-gke-cluster"
  location           = "us-central1-a"
  remove_default_node_pool = true
  initial_node_count = 1
  network            = google_compute_network.my-vpc.self_link
  subnetwork         = google_compute_subnetwork.private-subnet.self_link
  networking_mode    = "VPC_NATIVE"

  ip_allocation_policy {
    cluster_secondary_range_name  = "k8s-pod-range"
    services_secondary_range_name = "k8s-service-range"
  }
  private_cluster_config {
    enable_private_nodes    = true
    master_ipv4_cidr_block  = "172.168.0.0/28"
    enable_private_endpoint = false
  }
  depends_on = [
    google_compute_router_nat.cloud-router-nat
  ]
}

#################################################################
resource "google_container_node_pool" "my-node-pool" {
  name       = "nodepool1-${var.env_name}"
  location   = "us-central1-a"
  cluster    = google_container_cluster.cluster1.name
  node_count = 1
  max_pods_per_node = 5
  node_config {
    machine_type = "e2-small"
    preemptible  = true
    service_account = "terraform-sa-new@my-project-1575722702982.iam.gserviceaccount.com"
    oauth_scopes = [
        "https://www.googleapis.com/auth/cloud-platform",
        "https://www.googleapis.com/auth/compute",
        "https://www.googleapis.com/auth/devstorage.read_only",
        "https://www.googleapis.com/auth/logging.write",
        "https://www.googleapis.com/auth/monitoring",
    ]
    metadata = {
      disable-legacy-endpoints = "true"
    }
  }
  depends_on = [
    google_container_cluster.cluster1
  ]
}
#################################################################
# resource "google_container_node_pool" "my-node-pool2" {
#   name       = "nodepool2-${var.env_name}"
#   location   = "us-central1-a"
#   cluster    = google_container_cluster.cluster1.name
#   node_count = 1
#   max_pods_per_node = 20 

#   node_config {
#     preemptible  = true
#     machine_type = "e2-small"

#     service_account = "terraform-sa-new@my-project-1575722702982.iam.gserviceaccount.com"
#     oauth_scopes = [
#         "https://www.googleapis.com/auth/cloud-platform",
#         "https://www.googleapis.com/auth/compute",
#         "https://www.googleapis.com/auth/devstorage.read_only",
#         "https://www.googleapis.com/auth/logging.write",
#         "https://www.googleapis.com/auth/monitoring",
#     ]
#     metadata = {
#       disable-legacy-endpoints = "true"
#     }
#   }
  

# }

################################

resource "google_container_cluster" "public-cluster" {
  name               = "terraform-public-cluster"
  location           = "us-central1-a"
  remove_default_node_pool = true
  initial_node_count = 1
  network            = google_compute_network.my-vpc.self_link
  subnetwork         = google_compute_subnetwork.public-subnet.self_link
  networking_mode    = "VPC_NATIVE"

  ip_allocation_policy {
    cluster_secondary_range_name  = "k8s-pod-range-public"
    services_secondary_range_name = "k8s-service-range-public"
  }
  private_cluster_config {
    enable_private_nodes    = false
    enable_private_endpoint = false
  }
  depends_on = [
    google_compute_router_nat.cloud-router-nat
  ]
}

resource "google_container_node_pool" "public-node-pool" {
  name       = "public-node-pool-${var.env_name}"
  location   = "us-central1-a"
  cluster    = google_container_cluster.public-cluster.name
  node_count = 1
  max_pods_per_node = 5
  node_config {
    machine_type = "e2-small"
    preemptible  = true
    service_account = "terraform-sa-new@my-project-1575722702982.iam.gserviceaccount.com"
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
      "https://www.googleapis.com/auth/compute",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
    metadata = {
      disable-legacy-endpoints = "true"
    }
  }
  depends_on = [
    google_container_cluster.public-cluster
  ]
}

resource "google_container_node_pool" "public-node-pool2" {
  name       = "public-node-pool2-${var.env_name}"
  location   = "us-central1-a"
  cluster    = google_container_cluster.public-cluster.name
  node_count = 1
  max_pods_per_node = 5
  node_config {
    machine_type = "e2-small"
    preemptible  = true
    service_account = "terraform-sa-new@my-project-1575722702982.iam.gserviceaccount.com"
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
      "https://www.googleapis.com/auth/compute",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
    metadata = {
      disable-legacy-endpoints = "true"
    }
  }
  depends_on = [
    google_container_cluster.public-cluster
  ]
}

