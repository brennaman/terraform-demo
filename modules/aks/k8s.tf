provider "kubernetes" {
}

# Command line equivalent:
#
# kubectl create clusterrolebinding kubernetes-dashboard \
#   -n kube-system --clusterrole=cluster-admin \
#   --serviceaccount=kube-system:kubernetes-dashboard

resource "kubernetes_cluster_role_binding" "kubernetes-dashboard-rule" {
  metadata {
    name = "kubernetes-dashboard-rule"
  }

  role_ref {
    kind      = "ClusterRole"
    name      = "cluster-admin"
    api_group = "rbac.authorization.k8s.io"
  }

  subject {
    kind      = "ServiceAccount"
    namespace = "kube-system"
    name      = "kubernetes-dashboard"
    api_group = ""
  }

  depends_on = [azurerm_kubernetes_cluster.k8s]

}

# Command-line equivalent:
#
# kubectl create serviceaccount --namespace kube-system tiller
# kubectl create clusterrolebinding tiller-cluster-rule --clusterrole=cluster-admin --serviceaccount=kube-system:tiller
# helm init --service-account tiller

resource "kubernetes_service_account" "tiller" {
  metadata {
    name      = "tiller"
    namespace = "kube-system"
  }

  depends_on = [azurerm_kubernetes_cluster.k8s]

}

resource "kubernetes_cluster_role_binding" "tiller-cluster-rule" {
  metadata {
    name = "tiller-cluster-rule"
  }

  role_ref {
    kind      = "ClusterRole"
    name      = "cluster-admin"
    api_group = "rbac.authorization.k8s.io"
  }

  subject {
    kind      = "ServiceAccount"
    namespace = "kube-system"
    name      = "tiller"
    api_group = ""
  }

  provisioner "local-exec" {
    command = <<EOT
    az aks get-credentials --resource-group ${azurerm_resource_group.k8s.name} --name ${azurerm_kubernetes_cluster.k8s.name} --admin
    helm init --service-account tiller
    EOT
  }

  depends_on = [azurerm_kubernetes_cluster.k8s]

}