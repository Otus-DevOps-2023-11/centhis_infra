terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}


resource "yandex_compute_instance" "app" {
  name = var.reddit_app_vm_name

  labels = {
    tags = "reddit-app"
  }
  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = var.app_disk_image
    }
  }

  network_interface {
    subnet_id = var.subnet_id
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file(var.public_key_path)}"
  }
  connection {
    type  = "ssh"
    host  = self.network_interface.0.nat_ip_address
    user  = "ubuntu"
    agent = false
    # путь до приватного ключа
    private_key = file(var.private_key_path)
  }
  provisioner "file" {
    source      = "../modules/app/files/reddit.service"
    destination = "/tmp/reddit.service"
  }
  provisioner "remote-exec" {
    script = "../modules/app/files/deploy.sh"
  }
  provisioner "remote-exec" {
    inline = [
      "sudo sed -i '/.Service./a Environment=DATABASE_URL=${var.DATABASE_URL}:27017' /etc/systemd/system/reddit.service",
      "sudo systemctl daemon-reload",
      "sudo service reddit restart",
    ]
  }
}
