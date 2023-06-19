

# provider "kubernetes" {
#   config_path    = "~/.kube/config"
#   config_context = "cluster-1-dev"
# }

# resource "kubernetes_namespace" "dev" {
#   metadata {
#     name = "dev"
#   }
# }

# resource "kubernetes_deployment" "nginx" {
#   metadata {
#     name      = "nginx"
#     namespace = kubernetes_namespace.dev.metadata.0.name
#   }

#   spec {
#     replicas = 1

#     selector {
#       match_labels = {
#         app = "nginx"
#       }
#     }

#     template {
#       metadata {
#         labels = {
#           app = "nginx"
#         }
#       }

#       spec {
#         container {
#           image = "nginx"
#           name  = "nginx"
#           port {
#             container_port = 80
#           }
#         }
#       }
#     }
#   }
# }
# resource "kubernetes_namespace" "dev" {
#   metadata {
#     name = "dev"
#   }
# }

# resource "kubernetes_deployment" "nginx" {
#   metadata {
#     name = "nginx"
#     namespace = kubernetes_namespace.dev.metadata[0].name
#   }

#   spec {
#     replicas = 1

#     selector {
#       match_labels = {
#         app = "nginx"
#       }
#     }

#     template {
#       metadata {
#         labels = {
#           app = "nginx"
#         }
#       }

#       spec {
#         container {
#           name = "nginx"
#           image = "nginx:latest"
#           port {
#             container_port = 80
#           }
#         }
#       }
#     }
#   }
# }
