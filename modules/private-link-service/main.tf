
module "resource_group" {
  source              = "../resource-group"
  resource_group_name = var.resource_group_name
  location            = var.location
}

module "vnet" {
  source              = "../vnet"
  depends_on          = [module.resource_group]
  resource_group_name = var.resource_group_name
  location            = var.location
  vnet_name           = var.vnet_name
  vnet_address_space  = var.vnet_address_space
}

module "subnet" {
  source                  = "../subnet"
  depends_on              = [module.vnet]
  resource_group_name     = var.resource_group_name
  subnet_name             = var.subnet_name
  subnet_address_prefixes = var.subnet_address_prefixes
  vnet_name               = module.vnet.vnet_name
}

module "nat_gatewag_subnet" {
  source = "../nat_gateway"
  depends_on          = [module.subnet]
  nat_gateway_name    = var.nat_gateway_name
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = module.subnet.subnet_id
  
}

module "network_security_group" {
  source              = "../nsg"
  depends_on          = [module.subnet]
  nsg_name            = var.nsg_name
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = module.subnet.subnet_id
}

module "network_security_rules" {
  source              = "../network-security-rules"
  depends_on          = [module.network_security_group]
  nsg_name            = module.network_security_group.nsg_name
  resource_group_name = var.resource_group_name
  rule_name           = var.rule_name
}

module "loadbalancer" {
  depends_on          = [module.subnet]
  source              = "../load-balancer"
  location            = var.location
  resource_group_name = var.resource_group_name
  load_balancer_name  = var.load_balancer_name
  subnet_id           = module.subnet.subnet_id
}
module "vmss" {
  depends_on             = [module.loadbalancer]
  source                 = "../vmss"
  admin_password         = var.admin_password
  admin_username         = var.admin_username
  cloud_init_script_path = "${path.module}/scripts/cloud-init.sh"
  docker_image           = var.docker_image
  docker_password        = var.docker_password
  docker_username        = var.docker_username
  location               = var.location
  resource_group_name    = var.resource_group_name
  subnet_id              = module.subnet.subnet_id
  vmss_name              = var.vmss_name
  application_name       = var.application_name
  lb_backend_pool_id     = module.loadbalancer.lb_backend_pool_id
}
