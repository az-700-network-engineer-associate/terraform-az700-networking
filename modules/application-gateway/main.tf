module "resource_group" {
  source              = "../resource-group"
  resource_group_name = var.resource_group_name
  location            = var.location
  
}

module "vnet" {
  source              = "../vnet"
  depends_on = [ module.resource_group ]
  resource_group_name = module.resource_group.resource_group_name
  location            = module.resource_group.location
  vnet_name           = var.vnet_name
  vnet_address_space  = var.vnet_address_space
}

module "app_gateway_subnet" {
    source              = "../subnet"
    depends_on = [ module.vnet ]
    resource_group_name = module.resource_group.resource_group_name
    vnet_name = module.vnet.vnet_name
    subnet_name         = "${var.appgw_name}-subnet"
    subnet_address_prefixes = var.appwg_subnet_address_prefix
}

module "backend_pool_subnet" {
    source              = "../subnet"
    depends_on = [ module.vnet ]
    resource_group_name = module.resource_group.resource_group_name
    vnet_name = module.vnet.vnet_name
    subnet_name         = "${var.appgw_name}-backend-pool-subnet"
    subnet_address_prefixes = var.backend_pool_subnet_address_prefix
}

resource "azurerm_public_ip" "appgw_public_ip" {
  name                = "${var.appgw_name}-public-ip"
  location            = module.resource_group.location
  resource_group_name = module.resource_group.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
}
resource "azurerm_application_gateway" "appgw" {
  name                = var.appgw_name
  resource_group_name = module.resource_group.resource_group_name
  location            = module.resource_group.location
  sku {
    name     = "Standard_v2"
    tier     = "Standard_v2"
    capacity = 2
  }

  gateway_ip_configuration {
    name      = "${var.appgw_name}-ipconfig"
    subnet_id = module.app_gateway_subnet.subnet_id
  }

  frontend_port {
    name = "frontendPort"
    port = 80
  }

  frontend_ip_configuration {
    name                 = "${var.appgw_name}-frontendipconfig"
    public_ip_address_id = azurerm_public_ip.appgw_public_ip.id
  }

  # Configure the backend address pool with the IP addresses of the VMSS instances
  backend_address_pool {
    name = "product-cloud-service-backend-pool"
  }

  backend_address_pool {
    name = "order-cloud-service-backend-pool"
  }

  probe {
    name                                      = "order-cloud-service-health-probe"
    protocol                                  = "Http"
    path                                      = "/api/v1/actuator/health"
    interval                                  = 30
    timeout                                   = 5
    unhealthy_threshold                       = 3
    pick_host_name_from_backend_http_settings = true
  }

  probe {
    name                                      = "product-cloud-service-health-probe"
    protocol                                  = "Http"
    path                                      = "/api/v1/actuator/health"
    interval                                  = 30
    timeout                                   = 5
    unhealthy_threshold                       = 3
    pick_host_name_from_backend_http_settings = true

  }

  backend_http_settings {
    name                  = "product-cloud-service-http-settings"
    cookie_based_affinity = "Disabled"
    host_name             = "localhost"
    port                  = 9090
    protocol              = "Http"
    request_timeout       = 20
    probe_name            = "product-cloud-service-health-probe"
  }

  backend_http_settings {
    name                  = "order-cloud-service-http-settings"
    cookie_based_affinity = "Disabled"
    host_name             = "localhost"
    port                  = 9090
    protocol              = "Http"
    request_timeout       = 20
    probe_name            = "order-cloud-service-health-probe"
  }

  http_listener {
    name                           = "appgw-https-listener"
    frontend_ip_configuration_name = "${var.appgw_name}-frontendipconfig"
    frontend_port_name             = "frontendPort"
    protocol                       = "Http"
  }

  # 🔷 URL Path Map (IMPORTANT)
  url_path_map {
    name                               = "url-path-map"
    default_backend_address_pool_name  = "order-cloud-service-backend-pool"
    default_backend_http_settings_name = "order-cloud-service-http-settings"

    path_rule {
      name                       = "product-cloud-service-path-rule"
      paths                      = ["/api/v1/products", "/api/v1/products/*", "/api/v1/products/vm/info"]
      backend_address_pool_name  = "product-cloud-service-backend-pool"
      backend_http_settings_name = "product-cloud-service-http-settings"
    }

    path_rule {
      name                       = "order-cloud-service-path-rule"
      paths                      = ["/api/v1/orders/*", "/api/v1/orders", "/api/v1/orders/vm/info"]
      backend_address_pool_name  = "order-cloud-service-backend-pool"
      backend_http_settings_name = "order-cloud-service-http-settings"
    }
  }

  # 🔷 Routing Rule (connect listener → path map)
  request_routing_rule {
    name               = "routing-rule"
    rule_type          = "PathBasedRouting"
    http_listener_name = "appgw-https-listener"
    url_path_map_name  = "url-path-map"
    priority           = 100
  }
}

module "product-cloud-service-vmss" {
  source                 = "../vmss"
  depends_on = [ azurerm_application_gateway.appgw ]
  admin_password         = var.admin_password
  admin_username         = var.admin_username
  cloud_init_script_path = "${path.module}/scripts/cloud-init.sh"
  docker_image           = var.product_docker_image // Modify this variable to point to the product cloud service Docker image
  docker_password        = var.docker_password
  docker_username        = var.docker_username
  location               = module.resource_group.location
  resource_group_name    = module.resource_group.resource_group_name
  subnet_id              = module.backend_pool_subnet.subnet_id
  vmss_name              = "product-cloud-service-vmss"
  application_name       = "product-cloud-service"
  lb_backend_pool_id     = null
  vmss_size              = var.vmss_size
  appgw_backend_pool_id  = "${azurerm_application_gateway.appgw.id}/backendAddressPools/product-cloud-service-backend-pool"
}

module "order-cloud-service-vmss" {
  source                 = "../vmss"
  admin_password         = var.admin_password
  admin_username         = var.admin_username
  cloud_init_script_path = "${path.module}/scripts/cloud-init.sh"
  docker_image           = var.order_docker_image // Modify this variable to point to the order cloud service Docker image
  docker_password        = var.docker_password
  docker_username        = var.docker_username
  location               = module.resource_group.location
  resource_group_name    = module.resource_group.resource_group_name
  subnet_id              = module.backend_pool_subnet.subnet_id
  vmss_name              = "order-cloud-service-vmss"
  application_name       = "order-cloud-service"
  lb_backend_pool_id     = null
  vmss_size              = var.vmss_size
  appgw_backend_pool_id  = "${azurerm_application_gateway.appgw.id}/backendAddressPools/order-cloud-service-backend-pool"
}
