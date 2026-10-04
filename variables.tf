# === Yandex Cloud ===
variable "cloud_id" {
  description = "Yandex Cloud ID"
  type        = string
}

variable "folder_id" {
  description = "Yandex Cloud Folder ID"
  type        = string
}

variable "default_zone" {
  description = "Default availability zone"
  type        = string
  default     = "ru-central1-a"
}

# === Сеть ===
variable "network_name" {
  description = "VPC network name"
  type        = string
  default     = "diploma-vpc"
}

variable "subnets" {
  description = "Subnets configuration (name, zone, cidr)"
  type = map(object({
    zone = string
    cidr = string
  }))
  default = {
    "subnet-a" = {
      zone = "ru-central1-a"
      cidr = "10.10.1.0/24"
    }
    "subnet-b" = {
      zone = "ru-central1-b"
      cidr = "10.10.2.0/24"
    }
    "subnet-d" = {
      zone = "ru-central1-d"
      cidr = "10.10.3.0/24"
    }
  }
}

# === Kubernetes ===
variable "k8s_cluster_name" {
  description = "Managed Kubernetes cluster name"
  type        = string
  default     = "diploma-k8s"
}

variable "k8s_version" {
  description = "Kubernetes version"
  type        = string
  default     = "1.33"
}

variable "k8s_node_group_name" {
  description = "K8s node group name"
  type        = string
  default     = "diploma-k8s-nodes"
}

variable "k8s_node_count" {
  description = "Number of nodes in the node group"
  type        = number
  default     = 3
}

variable "k8s_node_cores" {
  description = "vCPU per node"
  type        = number
  default     = 2
}

variable "k8s_node_memory" {
  description = "RAM per node (GB)"
  type        = number
  default     = 2
}

variable "k8s_node_disk_size" {
  description = "Disk size per node (GB)"
  type        = number
  default     = 30
}
