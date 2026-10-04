# ============================================================
# Yandex Container Registry для Docker-образов
# ============================================================
resource "yandex_container_registry" "diploma" {
  name      = "diploma-registry"
  folder_id = var.folder_id

  labels = {
    project = "diploma"
  }
}

# ============================================================
# Репозиторий для приложения
# ============================================================
resource "yandex_container_repository" "diploma_app" {
  name = "${yandex_container_registry.diploma.id}/diploma-app"
}
