

resource "google_project_service" "cloud_build" {
    disable_on_destroy = false
    project = "my-project-1575722702982"
    service = "cloudbuild.googleapis.com"
}

resource "google_project_service" "source_repo" {
    disable_on_destroy = false
    project = "my-project-1575722702982"
    service = "sourcerepo.googleapis.com"
}

resource "google_sourcerepo_repository" "gateqeeper-repo" {
    name     = "gateqeeper-repo"
    project  = "my-project-1575722702982"
}

resource "google_cloudbuild_trigger" "trigger" {
    location = "global"
    project = "my-project-1575722702982"
    trigger_template {
        repo_name   = "gateqeeper-repo"
        branch_name = "master"
        dir         = ""
    }
    description = "My Cloud Build Trigger"
    filename    = "cloudbuild.yaml"
}