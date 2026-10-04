# ============================================================
# Сервисный аккаунт для кластера Kubernetes
# ============================================================
resource "yandex_iam_service_account" "k8s_cluster_sa" {
  name        = "diploma-k8s-cluster-sa"
  description = "Service account for diploma Kubernetes cluster"
}

# Роли для SA кластера
resource "yandex_resourcemanager_folder_iam_member" "k8s_cluster_sa_roles" {
  for_each = toset([
    "k8s.clusters.agent",
    "k8s.tunnelClusters.agent",
    "vpc.publicAdmin",
    "load-balancer.admin",
    "container-registry.images.puller",
  ])

  folder_id = var.folder_id
  role      = each.key
  member    = "serviceAccount:${yandex_iam_service_account.k8s_cluster_sa.id}"
}

# ============================================================
# Сервисный аккаунт для нод
# ============================================================
resource "yandex_iam_service_account" "k8s_node_sa" {
  name        = "diploma-k8s-node-sa"
  description = "Service account for diploma Kubernetes nodes"
}

resource "yandex_resourcemanager_folder_iam_member" "k8s_node_sa_roles" {
  for_each = toset([
    "container-registry.images.puller",
  ])

  folder_id = var.folder_id
  role      = each.key
  member    = "serviceAccount:${yandex_iam_service_account.k8s_node_sa.id}"
}

# ============================================================
# Managed Kubernetes кластер
# ============================================================
resource "yandex_kubernetes_cluster" "k8s" {
  name        = var.k8s_cluster_name
  description = "Diploma Managed Kubernetes cluster"

  network_id = yandex_vpc_network.main.id

  # --- Аргументы, которые остаются на уровне ресурса ---
  service_account_id      = yandex_iam_service_account.k8s_cluster_sa.id
  node_service_account_id = yandex_iam_service_account.k8s_node_sa.id
  release_channel         = "STABLE"

  # --- Блок master ---
  master {
    # Версия теперь ВНУТРИ master
    version = var.k8s_version

    # Региональный мастер (неотказоустойчивый) — дешевле
    regional {
      region = "ru-central1"

      location {
        zone      = yandex_vpc_subnet.subnets["subnet-a"].zone
        subnet_id = yandex_vpc_subnet.subnets["subnet-a"].id
      }
      location {
        zone      = yandex_vpc_subnet.subnets["subnet-b"].zone
        subnet_id = yandex_vpc_subnet.subnets["subnet-b"].id
      }
      location {
        zone      = yandex_vpc_subnet.subnets["subnet-d"].zone
        subnet_id = yandex_vpc_subnet.subnets["subnet-d"].id
      }
    }

    # Публичный IP для доступа к API-серверу из интернета
    public_ip = true

    # Окно обслуживания — теперь maintenance_policy
    maintenance_policy {
      auto_upgrade = true

      maintenance_window {
        day        = "monday"
        start_time = "23:00"
        duration   = "3h"
      }
    }
  }

  # Зависит от назначения ролей SA
  depends_on = [
    yandex_resourcemanager_folder_iam_member.k8s_cluster_sa_roles,
    yandex_resourcemanager_folder_iam_member.k8s_node_sa_roles,
  ]
}
