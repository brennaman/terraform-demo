provider "helm" {
}

resource "helm_release" "consul-release" {
  name       = "consul-release"
  chart      = "../modules/consul-helm"

  values = [
    "${file("helm-consul-values.yaml")}"
  ]

  depends_on = ["kubernetes_service_account.tiller", "kubernetes_cluster_role_binding.tiller-cluster-rule"]
}