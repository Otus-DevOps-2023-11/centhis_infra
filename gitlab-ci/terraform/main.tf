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

resource "yandex_compute_disk" "first-disk" {
  size     = "50"
  image_id = var.disk_image
}

resource "yandex_compute_instance" "gitlab-ci-vm" {
    # name = var.vm_name
    count = var.vm_count

    labels = {
        tags = "gitlab-ci-vm"
    }

    resources {
        cores = 4
        memory = 8
    }

    boot_disk {
        # initialize_params {

        # }
        disk_id = yandex_compute_disk.first-disk.id
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
      servers = yandex_compute_instance.gitlab-ci-vm.*.network_interface.0.nat_ip_address
    }
  )
  filename = "../hosts.cfg"
}
