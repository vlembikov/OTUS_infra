resource "google_compute_instance" "db" {
    name = "reddit-db"
    machine_type = "e2-micro"
    zone = var.zone
    tags = ["reddit-db"]
    
    boot_disk {
        initialize_params {
            image = var.db_disk_image
        }
    }

    network_interface {
        network = "default"
        access_config {
        }
    }

    metadata = {
        # путь до публичного ключа
        ssh-keys = "vlembikov:${file(var.public_key_path)}"
    }
}

# Правило firewall
resource "google_compute_firewall" "firewall_mongo" {
    name = "allow-mongo-default"
    network = "default"
    
    allow {
        protocol = "tcp"
        ports = ["27017"]
    }
    
    target_tags = ["reddit-db"]
    source_tags = ["reddit-app"]
}