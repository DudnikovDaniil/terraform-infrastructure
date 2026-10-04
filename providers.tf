provider "yandex" {
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
  zone      = var.default_zone

  # Аутентификация через ключ SA из переменной YC_SERVICE_ACCOUNT_KEY_FILE
}
