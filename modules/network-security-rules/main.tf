resource "azurerm_network_security_rule" "allow_http" {
  name                        = var.rule_name
  priority                    = 110
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"

  source_port_range           = "*"
  destination_port_range      = "80"

  source_address_prefix       = "Internet"
  destination_address_prefix  = "*"

  resource_group_name         = var.resource_group_name
  network_security_group_name = var.nsg_name
}

resource "azurerm_network_security_rule" "allow_lb_backend" {
  name                        = "Allow-LB-Backend"
  priority                    = 120
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"

  source_port_range           = "*"
  destination_port_range      = "8080"

  source_address_prefix       = "AzureLoadBalancer"
  destination_address_prefix  = "*"

  resource_group_name         = var.resource_group_name
  network_security_group_name = var.nsg_name
}

resource "azurerm_network_security_rule" "allow_app_traffic" {
  name                        = "Allow-App-Traffic"
  priority                    = 105
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"

  source_port_range           = "*"
  destination_port_range      = "8080"

  source_address_prefix       = "Internet"
  destination_address_prefix  = "*"

  resource_group_name         = var.resource_group_name
  network_security_group_name = var.nsg_name
}

resource "azurerm_network_security_rule" "allow_ssh" {
  name                        = "Allow-SSH"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"

  source_port_range           = "*"
  destination_port_range      = "22"

  source_address_prefix       = "Internet"
  destination_address_prefix  = "*"

  resource_group_name         = var.resource_group_name
  network_security_group_name = var.nsg_name
}