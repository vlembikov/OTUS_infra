terraform {
  # Версия terraform
  required_version = "0.12.8"
}

provider "google" {
  # Версия провайдера
  # ID проекта
  project = var.project

  region = var.region
}

#resource "google_compute_project_metadata" "default" {
#  metadata {
#    ssh-keys = <<EOF
#		appuser1:${file(var.public_key_path)}
#		appuser2:${file(var.public_key_path)}
#	EOF
#  }
#}

resource "google_compute_instance" "app" {
  name         = "reddit-app"
  machine_type = "e2-micro"
  zone         = var.zone
  tags         = ["reddit-app"]

  # определение загрузочного диска
  boot_disk {
    initialize_params {
      image = var.disk_image
    }
  }

  # определение сетевого интерфейса
  network_interface {
    # сеть, к которой присоединить данный интерфейс
    network = "default"

    # использовать ephemeral IP для доступа из Интернет
    access_config {}
  }

  metadata = {
    # путь до публичного ключа
    ssh-keys = "vlembikov:${file(var.public_key_path)}"
  }

  connection {
    type        = "ssh"
    user        = "vlembikov"
    agent       = false
    private_key = file(var.private_key_path)
    host        = google_compute_instance.app.network_interface.0.access_config.0.nat_ip
  }

  provisioner "file" {
    source      = "files/puma.service"
    destination = "/tmp/puma.service"
  }

  provisioner "remote-exec" {
    script = "files/deploy.sh"
  }
}

resource "google_compute_firewall" "firewall_puma" {
  name = "allow-puma-default"

  # Название сети, в которой действует правило
  network = "default"

  # Какой доступ разрешить
  allow {
    protocol = "tcp"
    ports    = ["9292"]
  }

  # Каким адресам разрешаем доступ
  source_ranges = ["0.0.0.0/0"]

  # Правило применимо для инстансов с перечисленными тэгами
  target_tags = ["reddit-app"]
}

