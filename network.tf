# VPC сеть
resource "yandex_vpc_network" "main" {
  name        = var.network_name
  description = "VPC for diploma Kubernetes cluster"

  labels = {
    project = "diploma"
  }
}

# Подсети в трёх зонах доступности
resource "yandex_vpc_subnet" "subnets" {
  for_each = var.subnets

  name           = each.key
  zone           = each.value.zone
  network_id     = yandex_vpc_network.main.id
  v4_cidr_blocks = [each.value.cidr]

  labels = {
    project = "diploma"
  }
}
