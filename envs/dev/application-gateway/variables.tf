variable "admin_password" {
  type = string
  description = "The password for the admin user"
}
variable "admin_username" {
  type = string
  description = "The username for the admin user"
}
variable "docker_username" {
  type = string
  description = "The username for the Docker registry"
}
variable "docker_password" {
  type = string
  description = "The password for the Docker registry"
}
variable "product_docker_image" {
  type = string
  description = "The name of the Docker image to run in the VMSS instances"
}
variable "order_docker_image" {
  type = string
  description = "The name of the Docker image to run in the VMSS instances"
}
variable "vmss_size" {
  type = string
  description = "The size of the virtual machine scale set instances"
}
variable "location" {
  type = string
}
variable "resource_group_name" {
  type = string
}
variable "appgw_name" {
  type = string
}
variable "appwg_subnet_address_prefix" {
  type = list(string)
}
variable "vnet_name" {
  type = string
}
variable "vnet_address_space" {
  type = list(string)
}
variable "backend_pool_subnet_address_prefix" {
  
}