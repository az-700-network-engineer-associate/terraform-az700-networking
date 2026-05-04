
resource "azurerm_linux_virtual_machine_scale_set" "vmss" {
  name                            = var.vmss_name
  resource_group_name             = var.resource_group_name
  location                        = var.location
  instances = 2
  sku                             = var.vmss_size
  admin_username                  = var.admin_username
  admin_password                  = var.admin_password
  disable_password_authentication = false
  custom_data = base64encode(templatefile("${var.cloud_init_script_path}", 
  {
    docker_username           = var.docker_username
    docker_password           = var.docker_password
    docker_image              = var.docker_image
    application_name          = var.application_name
    }))

  network_interface {
    name    = "${var.vmss_name}-nic"
    primary = true
     ip_configuration {
      name      = "${var.vmss_name}-ipconfig"
      subnet_id = var.subnet_id
      primary = true

      # Associate the VMSS instances with the load balancer backend pool
      load_balancer_backend_address_pool_ids = var.lb_backend_pool_id!=null?[var.lb_backend_pool_id]:[]
      application_gateway_backend_address_pool_ids = var.appgw_backend_pool_id!=null?[var.appgw_backend_pool_id]:[] 
    }
  }
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  
  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }
  
}
