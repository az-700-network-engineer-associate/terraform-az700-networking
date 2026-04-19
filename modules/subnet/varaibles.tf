variable "subnet_name" {
  description = "value of subnet name"
  type        = string
}
variable "subnet_address_prefixes" {
  description = "value of subnet address prefixes"
  type        = list(string)
}
variable "resource_group_name" {
  description = "The  name of the resource group name"
  type        = string
}

variable "vnet_name" {
  description = "value of vnet name"
  type        = string
}