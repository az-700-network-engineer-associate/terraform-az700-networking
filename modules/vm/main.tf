
resource "azurerm_linux_virtual_machine" "vm" {

  name                  = var.vm_name
  location              = var.location
  resource_group_name   = var.resource_group_name
  network_interface_ids = var.network_interface_ids
  size                  = var.vm_size
  custom_data = filebase64("${path.module}/scripts/install-nginx.sh")
  admin_username        =var.admin_username
  admin_password        = var.admin_password
  disable_password_authentication= false
  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }

  os_disk {
    name                 = "${var.vm_name}-osdisk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
}
