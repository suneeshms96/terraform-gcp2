
locals {
  env        = "dev"
  project_id = "my-project-1575722702982"
  branch     = "dev"
  region     = "us-central1"
  routing_mode  = "GLOBAL"
}

module "gateqeeper" {
  source      = "./gateqeeper"
  env_name    = local.env
  branch_name = local.branch
  project_id  = local.project_id
  region      = local.region
  routing_mode = local.routing_mode

}