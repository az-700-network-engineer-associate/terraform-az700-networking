terraform {
  backend "azurerm" {
    resource_group_name  = "rg-appgw-bootstrap-dev"
    storage_account_name = "storageacttfstatedev"
    container_name       = "tf-state-appgw-dev"
    key                  = "application-gateway-dev.tfstate"
  }
}