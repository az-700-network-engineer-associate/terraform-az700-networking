
resource "azurerm_public_ip" "lb_public_ip" {
  name                = "${var.load_balancer_name}-public-ip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
  
}
resource "azurerm_lb" "lb" {
    
  location            = var.location
  resource_group_name = var.resource_group_name
  name                = var.load_balancer_name
  sku                 = "Standard"

  frontend_ip_configuration {
    name                 = "${var.load_balancer_name}-lb-frontend-ip"
    public_ip_address_id = azurerm_public_ip.lb_public_ip.id
}
}
  resource azurerm_lb_backend_address_pool "backend_pool" {
    loadbalancer_id = azurerm_lb.lb.id
    name            = "${var.load_balancer_name}-backend-pool"
  }


  resource azurerm_lb_probe "http_probe" {
    loadbalancer_id = azurerm_lb.lb.id
    name            = "HttpProbe"
    protocol        = "Http"
    port            = 8080
    request_path    = "/actuator/health"
  }
  resource azurerm_lb_rule "http_rule" {
    loadbalancer_id            = azurerm_lb.lb.id
    name                       = "HttpRule"
    protocol                   = "Tcp"
    frontend_port              = 80
    backend_port               = 8080
    frontend_ip_configuration_name = "${var.load_balancer_name}-lb-frontend-ip"
    backend_address_pool_ids = [azurerm_lb_backend_address_pool.backend_pool.id]
    probe_id = azurerm_lb_probe.http_probe.id
  }
  
  
