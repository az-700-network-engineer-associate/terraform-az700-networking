
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
  source              = "../nat_gateway"
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
  vmss_size              = var.vmss_size
}

# Provider Private Link Service

data "azurerm_client_config" "current" {}

resource "azurerm_private_link_service" "pls" {
  depends_on = [ module.loadbalancer ]
  name                = var.provider_private_link_service_name
  location            = var.location
  resource_group_name = var.resource_group_name

  load_balancer_frontend_ip_configuration_ids = [
    module.loadbalancer.lb_frontend_ip_configuration_id
  ]

  nat_ip_configuration {
    name                       = "pls-nat-ip"
    private_ip_address         = "10.0.1.10"
    private_ip_address_version = "IPv4"
    subnet_id                  = module.subnet.subnet_id
    primary                    = true
  }

  # ✅ ADD THIS (MUST MATCH AUTO APPROVAL)
  visibility_subscription_ids = [
    data.azurerm_client_config.current.subscription_id
  ]

  # ✅ ADD THIS (MUST MATCH AUTO APPROVAL)
  auto_approval_subscription_ids = [
    data.azurerm_client_config.current.subscription_id
  ]
}

# Connection between consumer VM and Private Link Service
# Resource group and consumer VM will be created in the consumer module, 
#but we need to create the private endpoint here to connect to the private link service
resource "azurerm_resource_group" "rg-pls-consumer-dev" {
  name     = var.consumer_resource_group_name
  location = var.consumer_location
}

#Consumer VM

module "consumer_vnet" {
  source              = "../vnet"
  resource_group_name = azurerm_resource_group.rg-pls-consumer-dev.name
  location            = azurerm_resource_group.rg-pls-consumer-dev.location
  vnet_name           = var.consumer_vnet_name
  vnet_address_space  = var.consumer_vnet_address_space
}

module "consumer_subnet" {
  depends_on = [ module.consumer_vnet ]
  source                  = "../subnet"
  resource_group_name     = azurerm_resource_group.rg-pls-consumer-dev.name
  vnet_name               = var.consumer_vnet_name
  subnet_name             = var.consumer_subnet_name
  subnet_address_prefixes = var.consumer_subnet_address_prefixes
}

module "consumer_vm_nic" {
  depends_on = [ module.consumer_subnet ]
  source              = "../nic"
  resource_group_name = azurerm_resource_group.rg-pls-consumer-dev.name
  location            = azurerm_resource_group.rg-pls-consumer-dev.location
  subnet_id           = module.consumer_subnet.subnet_id
  vm_name             = var.consumer_vm_name
}

module "consumer_vm" {
  depends_on = [ module.consumer_vm_nic ]
  source                = "../vm"
  resource_group_name   = azurerm_resource_group.rg-pls-consumer-dev.name
  location              = azurerm_resource_group.rg-pls-consumer-dev.location
  vm_name               = var.consumer_vm_name
  admin_password        = var.admin_password
  admin_username        = var.admin_username
  vm_size               = var.consumer_vm_size
  network_interface_ids = [module.consumer_vm_nic.vm_nic_id]
}

# Connection between consumer VM and Private Link Service

module "consumer_private_endpoint" {
  depends_on = [ module.consumer_subnet ]
  source                          = "../private-endpoint"
  location                        = azurerm_resource_group.rg-pls-consumer-dev.location
  resource_group_name             = azurerm_resource_group.rg-pls-consumer-dev.name
  subnet_id                       = module.consumer_subnet.subnet_id
  private_endpoint_name           = var.consumer_private_endpoint_name
  private_link_service_id         = azurerm_private_link_service.pls.id
  private_service_connection_name = var.private_service_connection_name

}

