# Доказательства: Terraform Infrastructure

Скриншоты и логи создания инфраструктуры:

- VPC + 3 подсети.
- Managed K8s кластер.
- Node Group (3 ноды).
- 3 ВМ в облаке.

## Файлы

- `01-kubectl-nodes.*` — ноды K8s.
- `02-kubectl-pods.*` — поды.
- `03a-cluster-list.*` — список кластеров.
- `03b-cluster-details.*` — детали кластера.
- `04a-nodegroup-list.*` — список Node Group.
- `04b-nodegroup-details.*` — детали.
- `05-instances-list.*` — 3 ВМ.
- `06-network-resources.*` — VPC, подсети, SG.
- `09-terraform-state.*` — state.
- `10-yc-console-overview.png` — консоль.
- `11-yc-console-infrastructure-map.png` — карта.
