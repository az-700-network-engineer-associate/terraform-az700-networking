variable "location" {
  type = string
  description = "The location of the resource group where the network security group will be created"
  }  
variable "resource_group_name" {
  type = string
  description = "The name of the resource group where the network security group will be created"   
}      

variable "load_balancer_name" {
  type = string
  description = "The name of the load balancer to be created"
}

variable "subnet_id" {
  type = string
  description = "the values of subnet ID where the vmss exists"
}