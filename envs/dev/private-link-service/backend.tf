terraform {
  backend "azurerm" {
    resource_group_name  = "rg-private-link-service-dev"
    storage_account_name = "storageacttfstateplsdev"
    container_name       = "tfstate-container-pls-dev"
    key                  = "dev-pls.tfstate"
  }
}