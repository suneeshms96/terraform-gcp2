# resource "google_project_service" "project-apis" {
#   for_each = toset(var.project_apis)
#   project = var.project_id
#   service = each .value
#   disable_on_destroy = false
# }
