###############################################
# Curl pod, with using the manifest structure #
###############################################
resource "kubernetes_manifest" "curl" {
  manifest = {
    "apiVersion" = "v1"
    "kind"       = "Pod"
    "metadata" = {
      "name" = "curl"
      "namespace" = "default"
    }
    "spec" = {
      "containers" = [
        {
          "image"   = "curlimages/curl:latest"
          "name"    = "curl"
          "command" = ["sleep", "60000"]
        }
      ]
    }
  }
}