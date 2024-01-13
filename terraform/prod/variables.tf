variable "cloud_id" {
  description = "f"
}
variable "folder_id" {
  description = ""
}
variable "zone" {
  description = "Zone"
  default     = "ru-central1-a"
}
variable "service_account_key_file" {
  description = "Path to the service account key file"
}
variable "public_key_path" {
  description = "Path to the public key used for ssh access"
}
variable "private_key_path" {
  description = "Path to the private key used for ssh access"
}
variable "image_id" {
  description = "Image ID"
}
variable "subnet_id" {
  description = "Subnet ID"
}
variable "network_id" {
  description = "Network ID"
}
variable "count-reddit-apps" {
  description = "Count of reddit app servers"
  default     = 1
}
variable "app_disk_image" {
  description = "Disk image for reddit app"
  default     = "reddit-app-base"
}
variable "db_disk_image" {
  description = "Disk image for reddit db"
  default     = "reddit-db-base"
}
variable "reddit_app_vm_name" {
  description = "VM Name for reddit app"
}
variable "reddit_db_vm_name" {
  description = "VM Name for reddit db"
}
