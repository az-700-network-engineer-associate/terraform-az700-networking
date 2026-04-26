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
  vmss_size               = var.vmss_size
  application_name=var.application_name
  load_balancer_name=var.load_balancer_name
  nsg_name = var.nsg_name
  rule_name = var.rule_name
  nat_gateway_name = var.nat_gateway_name

  #Private Link Service
  provider_private_link_service_name = var.provider_private_link_service_name

  # Consumer service
  consumer_resource_group_name     = var.consumer_resource_group_name
  consumer_location                = var.consumer_location
  consumer_vnet_name               = var.consumer_vnet_name
  consumer_vnet_address_space      = var.consumer_vnet_address_space
  consumer_subnet_name             = var.consumer_subnet_name
  consumer_subnet_address_prefixes = var.consumer_subnet_address_prefixes
  consumer_vm_name = var.consumer_vm_name
  consumer_vm_size = var.consumer_vm_size

  # Link between consumer and provider
  consumer_private_endpoint_name = var.consumer_private_endpoint_name
  private_service_connection_name = var.private_service_connection_name
}
