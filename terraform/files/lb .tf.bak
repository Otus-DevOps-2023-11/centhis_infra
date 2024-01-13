#create target group
resource "yandex_alb_target_group" "reddit-app-target-group"{
  name = "reddit-app-target-group"

  target {
    subnet_id = var.subnet_id
    ip_address = yandex_compute_instance.app[0].network_interface.0.ip_address
  }
  target {
    subnet_id = var.subnet_id
    ip_address = yandex_compute_instance.app[1].network_interface.0.ip_address
  }
}

#create backend group
resource "yandex_alb_backend_group" "reddit-app-backend-group" {
  name                     = "reddit-app-backend-group"

  http_backend {
    name                   = "backend1"
    weight                 = 1
    port                   = 9292
    target_group_ids       = [yandex_alb_target_group.reddit-app-target-group.id]
    load_balancing_config {
      panic_threshold      = 90
    }
    healthcheck {
      timeout              = "10s"
      interval             = "2s"
      healthy_threshold    = 10
      unhealthy_threshold  = 15
      http_healthcheck {
        path               = "/"
      }
    }
  }
}

#create http router
resource "yandex_alb_http_router" "reddit-app-http-router" {
  name          = "reddit-app-http-router"
}

resource "yandex_alb_virtual_host" "reddit-app-lb-virtual-host" {
  name                    = "reddit-app-lb-virtual-host"
  http_router_id          = yandex_alb_http_router.reddit-app-http-router.id
  route {
    name                  = "route1"
    http_route {
      http_route_action {
        backend_group_id  = yandex_alb_backend_group.reddit-app-backend-group.id
        timeout           = "60s"
      }
    }
  }
}


#create load balancer
resource "yandex_alb_load_balancer" "reddit-app-balancer" {
  name        = "reddit-app-balancer"
  network_id  = var.network_id

  allocation_policy {
    location {
      zone_id   = var.zone
      subnet_id = var.subnet_id
    }
  }

  listener {
    name = "listener2"
    endpoint {
      address {
        external_ipv4_address {
        }
      }
      ports = [ 9292 ]
    }
    http {
      handler {
        http_router_id = yandex_alb_http_router.reddit-app-http-router.id
      }
    }
  }
}
