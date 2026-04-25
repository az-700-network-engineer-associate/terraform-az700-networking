output "lb_backend_pool_id" {
    value = azurerm_lb_backend_address_pool.backend_pool.id
}

output "lb_frontend_ip_configuration_id" {
    value = azurerm_lb.lb.frontend_ip_configuration[0].id
}