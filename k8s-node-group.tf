# ============================================================
# Node Group для Kubernetes кластера
# ============================================================
resource "yandex_kubernetes_node_group" "k8s_nodes" {
  name        = var.k8s_node_group_name
  description = "Diploma K8s node group (preemptible)"
  cluster_id  = yandex_kubernetes_cluster.k8s.id

  # Версия K8s — та же, что у кластера
  version = var.k8s_version

  # Метки на ноды
  labels = {
    project = "diploma"
    role    = "worker"
  }

  # === Расположение нод ===
  # 3 ноды в разных зонах — региональный мастер требует этого
  allocation_policy {
    location {
      zone = "ru-central1-a"
    }
    location {
      zone = "ru-central1-b"
    }
    location {
      zone = "ru-central1-d"
    }
  }

  # === Шаблон ВМ ===
  instance_template {
    platform_id = "standard-v3"

    # Сетевые интерфейсы
    network_interface {
      subnet_ids = [
        yandex_vpc_subnet.subnets["subnet-a"].id,
        yandex_vpc_subnet.subnets["subnet-b"].id,
        yandex_vpc_subnet.subnets["subnet-d"].id,
      ]
      nat = true  # публичный IP для pull образов
      security_group_ids = [
        yandex_vpc_security_group.k8s.id,
      ]
    }

    resources {
      cores         = var.k8s_node_cores
      memory        = var.k8s_node_memory
      core_fraction = 20  # 20% гарантии vCPU — дешевле
    }

    boot_disk {
      type = "network-hdd"
      size = var.k8s_node_disk_size
    }

    # Обычная ВМ (не прерываемая) — для гарантированного создания
    scheduling_policy {
      preemptible = false
    }

    # Метаданные: SSH-ключ для доступа к нодам (опционально)
    metadata = var.ssh_public_key != "" ? {
      ssh-keys = "ubuntu:${var.ssh_public_key}"
    } : {}

    # Контейнер-рантайм
    container_runtime {
      type = "containerd"
    }
  }

  # === Масштабирование ===
  scale_policy {
    fixed_scale {
      size = var.k8s_node_count
    }
  }

  # === Обслуживание ===
  maintenance_policy {
    auto_upgrade = true
    auto_repair  = true
  }

  # === Развёртывание ===
  deploy_policy {
    max_unavailable = 1
    max_expansion   = 0
  }
}
