variable "nat_gateway_name" {
  description = "The name of the NAT gateway"
  type        = string
}

variable "location" {
  description = "The location of the NAT gateway"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}
variable "subnet_id" {
  description = "The ID of the subnet to associate with the NAT gateway"
  type        = string
}