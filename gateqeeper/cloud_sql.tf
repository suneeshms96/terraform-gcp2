# resource "google_sql_database_instance" "my-sql-instance" {
#   name                = "cloud-sql-${var.env_name}"
#   database_version    = "MYSQL_5_7"
#   region              = var.region
#   settings {
#     tier              = "db-f1-micro"
#     disk_size         = "10"
#     ip_configuration {
#       ipv4_enabled       = false
#       private_network    = google_compute_network.my-vpc.id
#       require_ssl        = false
#     } 
#   }
#   depends_on = [
#     google_service_networking_connection.private_vpc_connection
#   ]
#   deletion_protection = false
# }

# resource "google_sql_user" "db-user" {
#   name        = "suneesh"
#   project     = var.project_id
#   instance    = google_sql_database_instance.my-sql-instance.name
#   password    = "idMzEsF-cP4Ld@>@"
#   host = google_compute_subnetwork.private-subnet.name
# }