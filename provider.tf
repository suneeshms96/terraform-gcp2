locals {
 terraform_service_account = "terraform-sa-new@my-project-1575722702982.iam.gserviceaccount.com"
}


provider "google" {
 alias = "impersonation"
 scopes = [
   "https://www.googleapis.com/auth/cloud-platform",
   "https://www.googleapis.com/auth/userinfo.email",
 ]
}

data "google_service_account_access_token" "default" {
 provider               	= google.impersonation
 target_service_account 	= local.terraform_service_account
 scopes                 	= ["userinfo-email", "cloud-platform"]
 lifetime               	= "3600s"
}

provider "google" {
 project 		    = "my-project-1575722702982"
 region             = "us-central1"
 access_token	    = data.google_service_account_access_token.default.access_token
 request_timeout 	= "60s"
}


terraform {
 backend "gcs" {
   bucket                      = "terraform-project-store"
   prefix                      = "terraform/state" 
   impersonate_service_account = "terraform-sa-new@my-project-1575722702982.iam.gserviceaccount.com"
 }
}

provider "google-beta" {
  project = "my-project-1575722702982"
  region = "us-central1"
  access_token = data.google_service_account_access_token.default.access_token
}

