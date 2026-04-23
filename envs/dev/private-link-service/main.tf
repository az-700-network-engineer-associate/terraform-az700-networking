module "private_link_service" {
  source                  = "../../../modules/private-link-service"
  admin_password          = var.admin_password
  admin_username          = var.admin_username
  docker_image            = var.docker_image
  docker_password         = var.docker_password
  docker_username         = var.docker_username
  location                = var.location
  resource_group_name     = var.resource_group_name
  subnet_address_prefixes = var.subnet_address_prefixes
  subnet_name             = var.subnet_name
  vnet_address_space      = var.vnet_address_space
  vnet_name               = var.vnet_name
  vmss_name               = var.vmss_name
  application_name=var.application_name
  load_balancer_name=var.load_balancer_name
  nsg_name = var.nsg_name
  rule_name = var.rule_name

}
