terraform {
  backend "azurerm" {
    resource_group_name  = "rg-pls-bootstrap-dev"
    storage_account_name = "storageacttfstatedev"
    container_name       = "tf-state-pls-dev"
    key                  = "pls-dev.tfstate"
  }
}