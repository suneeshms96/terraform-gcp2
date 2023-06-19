# resource "google_redis_instance" "redis" {
#   name               = "redis-instance-suneesh-${var.env_name}"
#   tier               = "BASIC"
#   memory_size_gb     = 2
#   redis_version      = "REDIS_6_X"
#   region             = var.region
#   project            = var.project_id
#   authorized_network = google_compute_network.my-vpc.self_link
#   depends_on = [
#     google_service_networking_connection.private_vpc_connection
#   ]

# }


