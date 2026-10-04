terraform {
  required_version = ">= 1.5.0"

  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "~> 0.130"
    }
  }

  # S3 backend для хранения terraform state в Yandex Object Storage
  backend "s3" {
    endpoints = {
      s3 = "https://storage.yandexcloud.net"
    }
    bucket = "diploma-tfstate-dudnikov-7efeef"
    key    = "infrastructure/terraform.tfstate"
    region = "ru-central1"

    # Эти параметры нужны, потому что Yandex Object Storage — S3-совместимый,
    # но не полностью AWS S3.
    skip_region_validation      = true
    skip_credentials_validation = true
    skip_requesting_account_id  = true
    skip_s3_checksum            = true
  }
}
