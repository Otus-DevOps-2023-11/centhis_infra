
terraform {
  # required_providers {
  #   yandex = {
  #     source = "yandex-cloud/yandex"
  #   }
  # }
  #  required_version = ">= 0.13"

  # backend "s3" {
  #   endpoints = {
  #     s3 = "https://storage.yandexcloud.net"
  #   }
  #   bucket = "centhis-terraform-states"
  #   region = "ru-central1"
  #   key    = "stage.tfstate"

  #   skip_region_validation      = true
  #   skip_credentials_validation = true
  #   skip_requesting_account_id  = true # необходимая опция Terraform для версии 1.6.1 и старше.
  #   skip_s3_checksum            = true # необходимая опция при описании бэкенда для Terraform версии 1.6.3 и старше.

  #   dynamodb_endpoint = "https://docapi.serverless.yandexcloud.net/ru-central1/b1gove26p9mb8pcae86f/etnk85pvfvttsl35kc10"
  #   dynamodb_table    = "table980"
  # }
}


provider "yandex" {
  service_account_key_file = var.service_account_key_file
  cloud_id                 = var.cloud_id
  folder_id                = var.folder_id
  zone                     = var.zone
}

module "app" {
  source             = "../modules/app"
  public_key_path    = var.public_key_path
  app_disk_image     = var.app_disk_image
  subnet_id          = var.subnet_id
  reddit_app_vm_name = var.reddit_app_vm_name
  private_key_path   = var.private_key_path
  DATABASE_URL       = module.db.external_ip_address_db
  #depends_on         = [module.db]

}
module "db" {
  source            = "../modules/db"
  public_key_path   = var.public_key_path
  db_disk_image     = var.db_disk_image
  subnet_id         = var.subnet_id
  reddit_db_vm_name = var.reddit_db_vm_name
  private_key_path  = var.private_key_path
}
