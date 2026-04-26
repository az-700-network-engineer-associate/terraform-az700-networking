variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
  
}
variable "location" {
  description = "The location of the resource group."
  type        = string
}
variable "subnet_id" {
  description = "The ID of the subnet."
  type        = string
}
variable "vm_name" {
  description = "The name of the virtual machine."
  type        = string
}