# Terraform Infrastructure

Модуль Terraform для создания облачной инфраструктуры дипломного практикума в Yandex.Cloud: VPC, подсети, security group, Managed Kubernetes кластер и Node Group.

**Автор:** Дудников Даниил
**Группа:** FOPS-41

---

## Что создаётся

- VPC `diploma-vpc`
- Три подсети в трёх зонах доступности:
  - `subnet-a` — ru-central1-a, 10.10.1.0/24
  - `subnet-b` — ru-central1-b, 10.10.2.0/24
  - `subnet-d` — ru-central1-d, 10.10.3.0/24
- Security Group `diploma-k8s-sg`
- Managed Kubernetes кластер `diploma-k8s` (v1.33, региональный мастер)
- Node Group `diploma-k8s-nodes` (3 ноды, standard-v3, 2 vCPU / 2 GB RAM, 30 GB HDD)
- Сервисные аккаунты для кластера и нод

---

## Backend

State хранится в S3-бакете, созданном в репозитории [terraform-bootstrap](https://github.com/DudnikovDaniil/terraform-bootstrap).

- Bucket: `diploma-tfstate-dudnikov-7efeef`
- Key: `infrastructure/terraform.tfstate`

---

## Структура

```
.
├── main.tf
├── versions.tf
├── providers.tf
├── variables.tf
├── terraform.tfvars
├── network.tf
├── security-groups.tf
├── k8s.tf
├── k8s-node-group.tf
├── container-registry.tf
├── outputs.tf
└── README.md
```

---

## Применение

```bash
terraform init
terraform plan
terraform apply
```

---

## Ссылки

- [Основной проект diploma-app](https://github.com/DudnikovDaniil/diploma-app)
- [terraform-bootstrap](https://github.com/DudnikovDaniil/terraform-bootstrap)

---

## Лицензия

Учебный проект. Свободное использование в образовательных целях.

© 2026, Дудников Даниил
