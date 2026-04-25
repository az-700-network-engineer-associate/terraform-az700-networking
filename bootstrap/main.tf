resource "azurerm_resource_group" "rg-pls-bootstrap-dev" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_storage_account" "tfstatestorageact" {
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.rg-pls-bootstrap-dev.name
  location                 = azurerm_resource_group.rg-pls-bootstrap-dev.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}
resource "azurerm_storage_container" "tfstatecontainer" {
  name                 = var.storage_container_name
  storage_account_id = azurerm_storage_account.tfstatestorageact.id
  container_access_type = "private"
}