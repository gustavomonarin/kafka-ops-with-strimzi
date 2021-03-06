provider "kubernetes" {
  config_path = "~/.kube/config"
  config_context_cluster = "minikube"
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
    config_context_cluster = "minikube"
  }
}

# resource "kubernetes_namespace" "legacy-kafka-namespace" {
#   metadata {
#     name = "legacy-kafka"
#   }
# }


resource "helm_release" "legacy-kafka-helm" {
  name       = "legacy-kafka-helm"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "kafka"
  version    = "12.7.4"
  namespace  = "legacy-kafka"
  create_namespace = true
}

resource "helm_release" "strimzi-operator" {
  name       = "strimzi-operator"
  repository = "https://strimzi.io/charts/"
  chart      = "strimzi-kafka-operator"
  version    = "0.21.1"
  namespace  = "strimzi-operator"
  create_namespace = true
}