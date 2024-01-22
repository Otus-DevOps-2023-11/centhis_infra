terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"

  backend "s3" {
    endpoints = {
      s3 = "https://storage.yandexcloud.net"
    }
    bucket = "centhis-terraform-states"
    region = "ru-central1"
    key    = "stage.tfstate"

    skip_region_validation      = true
    skip_credentials_validation = true
    skip_requesting_account_id  = true # необходимая опция Terraform для версии 1.6.1 и старше.
    skip_s3_checksum            = true # необходимая опция при описании бэкенда для Terraform версии 1.6.3 и старше.

    dynamodb_endpoint = "https://docapi.serverless.yandexcloud.net/ru-central1/b1gove26p9mb8pcae86f/etnk85pvfvttsl35kc10"
    dynamodb_table    = "table980"
  }
}
