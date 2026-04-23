variable "nsg_name" {
  description = "The name of the network security group"
  type        = string
}
variable "location" {
  description = "The location of the resources"
  type        = string
}
variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}
variable "subnet_id" {
  type = string
  description = "The ID of the subnet to associate with the network security group"
}
