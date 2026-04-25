variable "storage_account_name" {
  description = "The name of the storage account. Storage account names must be between 3 and 24 characters in length and may contain numbers and lowercase letters only."
  type        = string
  
}
variable "storage_container_name" {
  description = "The name of the storage container. Container names must be between 3 and 63 characters in length and may contain numbers, lowercase letters, and hyphens only. Container names must begin with a letter or number, and must end with a letter or number."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}
variable "location" {
  description = "The location of the resource group"
  type        = string
}