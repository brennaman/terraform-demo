provider "kubernetes" {
}

resource "null_resource" "cluster1" {

    provisioner "local-exec" {
    command = <<EOT
    az login --service-principal --username ${var.AZURE_CLIENT_ID} --password ${var.AZURE_CLIENT_SECRET} --tenant ${var.AZURE_TENANT_ID}
    az aks get-credentials --resource-group ${azurerm_resource_group.k8s.name} --name ${azurerm_kubernetes_cluster.k8s.name} --overwrite-existing --admin
    kubectl get nodes
    EOT
  }
}

# Command line equivalent:

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

  depends_on = ["null_resource.cluster1"]

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

  depends_on = ["null_resource.cluster1"]

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
    command = "helm init --service-account tiller"
  }

  depends_on = ["null_resource.cluster1"]

}