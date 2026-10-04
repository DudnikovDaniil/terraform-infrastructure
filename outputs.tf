# === Сеть ===
output "vpc_id" {
  description = "VPC network ID"
  value       = yandex_vpc_network.main.id
}

output "subnet_ids" {
  description = "Map of subnet names to IDs"
  value = {
    for k, v in yandex_vpc_subnet.subnets : k => v.id
  }
}

output "subnet_zones" {
  description = "Map of subnet names to zones"
  value = {
    for k, v in yandex_vpc_subnet.subnets : k => v.zone
  }
}

# === Security Group ===
output "k8s_sg_id" {
  description = "Kubernetes security group ID"
  value       = yandex_vpc_security_group.k8s.id
}

# === Kubernetes ===
output "k8s_cluster_id" {
  description = "Managed Kubernetes cluster ID"
  value       = yandex_kubernetes_cluster.k8s.id
}

output "k8s_cluster_endpoint" {
  description = "Kubernetes API endpoint"
  value       = yandex_kubernetes_cluster.k8s.master[0].external_v4_endpoint
}

output "k8s_cluster_ca_certificate" {
  description = "Kubernetes cluster CA certificate"
  value       = yandex_kubernetes_cluster.k8s.master[0].cluster_ca_certificate
  sensitive   = true
}

# === Node Group ===
output "k8s_node_group_id" {
  description = "K8s node group ID"
  value       = yandex_kubernetes_node_group.k8s_nodes.id
}

# === Container Registry ===
output "registry_id" {
  description = "Yandex Container Registry ID"
  value       = yandex_container_registry.diploma.id
}

output "registry_name" {
  description = "Yandex Container Registry name"
  value       = yandex_container_registry.diploma.name
}
