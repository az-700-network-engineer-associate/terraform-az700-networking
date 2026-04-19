

module "vnet" {
  source              = "../vnet"
  resource_group_name = var.resource_group_name
  location            = var.location
  vnet_name           = var.vnet_name
  vnet_address_space  = var.vnet_address_space
}

module "subnet" {
  source                  = "../subnet"
  resource_group_name     = var.resource_group_name
  subnet_name             = var.subnet_name
  subnet_address_prefixes = var.subnet_address_prefixes
  vnet_name               = module.vnet.vnet_name

}

module "vm" {
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
}
