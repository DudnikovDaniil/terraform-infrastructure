# ============================================================
# Security Group для Kubernetes кластера
# ============================================================
resource "yandex_vpc_security_group" "k8s" {
  name        = "diploma-k8s-sg"
  description = "Security group for diploma Kubernetes cluster"
  network_id  = yandex_vpc_network.main.id

  labels = {
    project = "diploma"
  }

  # === Входящий трафик ===

  # ICMP (ping) — для отладки
  ingress {
    description    = "ICMP for debugging"
    protocol       = "ICMP"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

  # SSH (22) — для подключения к нодам
  ingress {
    description    = "SSH to nodes"
    protocol       = "TCP"
    port           = 22
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

  # HTTP (80) — для Ingress/LoadBalancer
  ingress {
    description    = "HTTP from internet"
    protocol       = "TCP"
    port           = 80
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

  # HTTPS (443) — для Ingress/LoadBalancer
  ingress {
    description    = "HTTPS from internet"
    protocol       = "TCP"
    port           = 443
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

  # Kubernetes API (6443) — доступ к API-серверу
  ingress {
    description    = "Kubernetes API"
    protocol       = "TCP"
    port           = 6443
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

  # Внутренний трафик между нодами (весь диапазон подсетей)
  ingress {
    description    = "Internal traffic within VPC"
    protocol       = "ANY"
    v4_cidr_blocks = [
      "10.10.1.0/24",
      "10.10.2.0/24",
      "10.10.3.0/24",
    ]
  }

  # === Исходящий трафик ===

  # Весь исходящий разрешён (для pull образов, обновлений)
  egress {
    description    = "Allow all outbound"
    protocol       = "ANY"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}
