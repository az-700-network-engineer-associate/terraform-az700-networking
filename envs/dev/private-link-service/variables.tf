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

variable "location" {
  description = "The location of the resources"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "subnet_address_prefixes" {
  description = "The address prefixes for the subnet"
  type        = list(string)
}

variable "subnet_name" {
  description = "The name of the subnet"
  type        = string
}

variable "vnet_address_space" {
  description = "The address space for the virtual network"
  type        = list(string)
}

variable "application_name" {
  type = string
  description = "The name of the application to run in the Docker container"
}

variable "vnet_name" {
  description = "The name of the virtual network"
  type        = string
}

variable "vmss_name" {
  description = "The name of the virtual machine scale set"
  type        = string
}
variable "load_balancer_name" {
  description = "The name of the load balancer"
  type        = string
}
variable "nsg_name" {
  type = string
  description = "the name of the network security group"
}
variable "rule_name" {
  type = string
  description = "The name of the network security rule"
}
variable "storage_account_name" {
  description = "The name of the storage account. Storage account names must be between 3 and 24 characters in length and may contain numbers and lowercase letters only."
  type        = string
  
}

variable "storage_container_name" {
  description = "The name of the storage container. Container names must be between 3 and 63 characters in length and may contain numbers, lowercase letters, and hyphens only. Container names must begin with a letter or number, and must end with a letter or number."
  type        = string
}

variable "tfstate_key" {
  description = "The name of the tfstate file in the storage account container"
  type        = string  
}