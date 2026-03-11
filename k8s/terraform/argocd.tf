resource "helm_release" "argocd" {
  name             = "argocd"
  namespace        = "argocd"
  create_namespace = true

  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"

  values = [
    file("values/argocd.yaml")
  ]
}

# Git Generator - Directories
resource "argocd_application_set" "git_directories" {
  depends_on = [ helm_release.argocd ]

  metadata {
    name = "git-directories"
  }

  spec {
    go_template = true
    go_template_options = ["missingkey=error"]

    generator {
      matrix {
        generator {
          list {
            elements = [
              { namespace = "public-apps", multiple = true },
              { namespace = "cloudflared" },
              { namespace = "glance" },
            ]
          }
        }

        generator {
          git {
            repo_url = "https://github.com/fouadchamoun/homelab.git"
            revision = "refs/heads/main"

            directory {
              path = "k8s/apps/{{ .namespace }}{{ if get . \"multiple\" }}/*{{ end }}"
            }
          }
        }
      }
    }

    template {
      metadata {
        name = "{{ .path.basename }}"
      }

      spec {
        source {
          repo_url        = "https://github.com/fouadchamoun/homelab.git"
          target_revision = "refs/heads/main"
          path            = "{{ .path.path }}"
        }

        destination {
          server    = "https://kubernetes.default.svc"
          namespace = "{{ .namespace }}"
        }

        sync_policy {
          automated {
            prune       = false
            allow_empty = false
            self_heal   = false
          }

          retry {
            limit = "0"
            # backoff {
            #   factor = ""
            #   duration = ""
            #   max_duration = ""
            # }
          }

          sync_options = [
            "CreateNamespace=true",
            "ApplyOutOfSyncOnly=true",
            "PruneLast=true",
            "ServerSideApply=true",
            "FailOnSharedResource=true"
          ]
        }
      }
    }
  }
}
