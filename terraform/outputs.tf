output "external_ip_address_app" {
  value = yandex_compute_instance.app[0].network_interface.0.nat_ip_address
}
output "internal_ip_address_app" {
  value = yandex_compute_instance.app[0].network_interface.0.ip_address
}
output "external_ip_address_lb" {
  value = yandex_alb_load_balancer.reddit-app-balancer.listener[0].endpoint[0].address[0].external_ipv4_address
}
