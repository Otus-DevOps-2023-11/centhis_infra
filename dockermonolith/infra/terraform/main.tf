terraform {
    required_providers {
        yandex = {
            source = "yandex-cloud/yandex"
        }
    }
    required_version = ">= 0.13"
}

provider "yandex"{
    service_account_key_file = var.service_account_key_file
    cloud_id                 = var.cloud_id
    folder_id                = var.folder_id
    zone                     = var.zone
}

resource "yandex_compute_instance" "app" {
    # name = var.vm_name
    count = var.vm_count

    labels = {
        tags = "docker-monolith"
    }

    resources {
        cores = 2
        memory = 2
    }

    boot_disk {
        initialize_params {
            image_id = var.disk_image
        }
    }

    network_interface {
        subnet_id = var.subnet_id
        nat = true
    }

    metadata = {
        ssh-keys = "ubuntu:${file(var.public_key_path)}"
    }

    connection {
        type = "ssh"
        host = self.network_interface.0.nat_ip_address
        user = "ubuntu"
        agent = false
        private_key = file(var.private_key_path)
    }
}
resource "local_file" "hosts" {
    content = templatefile("templates/hosts.tpl",
    {
      servers = yandex_compute_instance.app.*.network_interface.0.nat_ip_address
    }
  )
  filename = "../ansible/hosts.cfg"
}
