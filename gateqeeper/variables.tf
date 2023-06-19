
variable "project_id" {
  type = string
}

variable "env_name" {
  type = string
}

variable "branch_name" {
  type = string
}

variable "region" {
  type = string
}

variable "routing_mode" {
  type = string
}

# variable "project_apis" {
#   type    = list
#   default = [
#     "autoscaling.googleapis.com",
#     "bigquery.googleapis.com",
#     "bigquerydatapolicy.googleapis.com",
#     "bigquerymigration.googleapis.com",
#     "bigquerystorage.googleapis.com",
#     "cloudidentity.googleapis.com",
#     "cloudresourcemanager.googleapis.com",
#     "cloudtrace.googleapis.com",
#     "compute.googleapis.com",
#     "container.googleapis.com",
#     "containerfilesystem.googleapis.com",
#     "containerregistry.googleapis.com",
#     "deploymentmanager.googleapis.com",
#     "dns.googleapis.com",
#     "edgecache.googleapis.com",
#     "iam.googleapis.com",
#     "iamcredentials.googleapis.com",
#     "logging.googleapis.com",
#     "monitoring.googleapis.com",
#     "networkmanagement.googleapis.com",
#     "networkservices.googleapis.com",
#     "oslogin.googleapis.com",
#     "pubsub.googleapis.com",
#     "redis.googleapis.com",
#     "servicenetworking.googleapis.com",
#     "serviceusage.googleapis.com",
#     # "source.googleapis.com",
#     "sql-component.googleapis.com",
#     "sqladmin.googleapis.com",
#     "storage-api.googleapis.com",
#     "storage-component.googleapis.com",
#     "storage.googleapis.com",
#     "vpcaccess.googleapis.com"
#     ]
#   description = "This variable contains list of APIs that need to be enabled."
# }

