variable "subnet_id" {
  description = "Subnets for modules"
}
variable "app_disk_image" {
  description = "Disk image for reddit app"
  default     = "reddit-app-base"
}
variable "public_key_path" {
  description = "Path to the public key used for ssh access"
}
variable "private_key_path" {
  description = "Path to the private key used for ssh access"
}
variable "reddit_app_vm_name" {
  description = "VM Name for reddit app"
}
variable "DATABASE_URL" {
  description = "Database URL"
}
