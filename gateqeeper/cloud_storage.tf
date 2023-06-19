# resource "google_storage_bucket" "my-bucket" {
#     name     = "my-storage-bucket-${var.env_name}"
#     location = var.region
#     versioning {
#         enabled = true
#     }
# }
