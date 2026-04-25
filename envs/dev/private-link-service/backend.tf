terraform {
  backend "azurerm" {
    resource_group_name  = "rg-pls-dev"
    storage_account_name = "storageacttfstateplsdev"
    container_name       = "tfstate-container-pls-dev"
    key                  = "dev-pls.tfstate"
  }
}