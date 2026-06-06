module "application-gateway-waf-dev" {
  source = "../../../modules/application-gateway-waf"
    admin_password         = var.admin_password
    admin_username         = var.admin_username
    docker_password        = var.docker_password
    docker_username        = var.docker_username
    product_docker_image = var.product_docker_image
    order_docker_image = var.order_docker_image
    location               = var.location
    resource_group_name    = var.resource_group_name
    vmss_size              = var.vmss_size
    appgw_name = var.appgw_name
    appwg_subnet_address_prefix = var.appwg_subnet_address_prefix
    vnet_name = var.vnet_name
    vnet_address_space = var.vnet_address_space
    backend_pool_subnet_address_prefix = var.backend_pool_subnet_address_prefix
    
}

