#VMSS subnet → NAT Gateway → Internet
#Step 1 — Create Public IP for NAT Gateway
resource "azurerm_public_ip" "nat_gateway_public_ip" {
  name                = "${var.nat_gateway_name}-public-ip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
}

#Step 2 — Create NAT Gateway
resource "azurerm_nat_gateway" "nat_gateway" {
  name                = var.nat_gateway_name
  location            = var.location
  resource_group_name = var.resource_group_name
}

#Step 3 — Associate Public IP with NAT Gateway
resource "azurerm_nat_gateway_public_ip_association" "nat_gateway_public_ip_association" {
  nat_gateway_id   = azurerm_nat_gateway.nat_gateway.id
  public_ip_address_id = azurerm_public_ip.nat_gateway_public_ip.id
}


#Step 4 — Attach NAT Gateway to VMSS Subnet ⭐ (IMPORTANT)
resource "azurerm_subnet_nat_gateway_association" "subnet_nat_gateway_association" {
  subnet_id      = var.subnet_id
  nat_gateway_id = azurerm_nat_gateway.nat_gateway.id
}
