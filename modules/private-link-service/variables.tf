variable "resource_group_name" {
  description = "The  name of the resource group name"
  type        = string
}
variable "location" {
  description = "The location of the resource group"
  type        = string
}
variable "vnet_name" {
  description = "value of vnet name"
  type        = string
}
variable "vnet_address_space" {
  description = "value of vnet address space"
  type        = list(string)
}
variable "subnet_address_prefixes" {
  description = "value of subnet address prefixes"
  type        = list(string)
}
variable "subnet_name" {
  description = "value of subnet name"
  type        = string
}

variable "admin_password" {
  description = "The password for the admin user"
  type        = string
}

variable "admin_username" {
  description = "The username for the admin user"
  type        = string
}

variable "docker_image" {
  description = "The Docker image to use"
  type        = string
}

variable "docker_password" {
  description = "The password for the Docker registry"
  type        = string
}

variable "docker_username" {
  description = "The username for the Docker registry"
  type        = string
}
variable "vmss_name" {
  description = "value of vmss name"
  type        = string
}