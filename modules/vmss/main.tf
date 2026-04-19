
resource "azurerm_linux_virtual_machine_scale_set" "vmss" {
  name                            = var.vmss_name
  resource_group_name             = var.resource_group_name
  location                        = var.location
  instances = 2
  sku                             = "Standard_DC1ds_v3"
  admin_username                  = var.admin_username
  admin_password                  = var.admin_password
  disable_password_authentication = false
  custom_data = base64encode(templatefile("${var.cloud_init_script_path}"), 
  {
    docker_username           = var.docker_username
    docker_password           = var.docker_password
    docker_image              = var.docker_image
    })
    
  network_interface {
    name    = "${var.vmss_name}-nic"
    primary = true

    ip_configuration {
      name      = "${var.vmss_name}-ipconfig"
      subnet_id = var.subnet_id
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
