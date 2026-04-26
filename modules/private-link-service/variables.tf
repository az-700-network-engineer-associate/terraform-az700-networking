# Variables for the Private Link Service module

# Provider variables

# Resource group and location
variable "resource_group_name" {
  description = "The  name of the resource group name"
  type        = string
}
variable "location" {
  description = "The location of the resource group"
  type        = string
}

# Virtual network and subnet
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

# Virtual machine scale set

 variable "vmss_name" {
  description = "value of vmss name"
  type        = string
}
variable "vmss_size" {
  type = string
  description = "The size of the virtual machine scale set"
}
variable "admin_password" {
  description = "The password for the admin user"
  type        = string
}

variable "admin_username" {
  description = "The username for the admin user"
  type        = string
}

# Docker registry
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

variable "application_name" {
  type = string
  description = "The name of the application to run in the Docker container"
}


# Load balancer
variable "load_balancer_name" {
  description = "value of load balancer name"
}

# Network Security Group and Rule
variable "nsg_name" {
  type = string
  description = "value of nsg name"
}
variable "rule_name" {
  type = string
  description = "The name of the network security rule"
}

variable "nat_gateway_name" {
  description = "The name of the NAT gateway"
  type        = string
}

# Provider Private Link Service
variable "provider_private_link_service_name" {
  description = "The name of the private link service created by the provider"
  type        = string
}


# Consumer variables

# Resource group and location

variable "consumer_resource_group_name" {
  description = "The name of the consumer resource group"
  type        = string
}
variable "consumer_location" {
  description = "The location of the consumer resource group"
  type        = string
}

# Consumer virtual network and subnet
variable "consumer_vnet_name" {
  description = "The name of the consumer virtual network"
  type        = string
}
variable "consumer_vnet_address_space" {
  description = "The address space of the consumer virtual network"
  type        = list(string)
}
variable "consumer_subnet_name" {
  description = "The name of the consumer subnet"
  type        = string
}
variable "consumer_subnet_address_prefixes" {
  description = "The address prefixes of the consumer subnet"
  type        = list(string)
}

# Consumer virtual machine
variable "consumer_vm_name" {
  type = string
  description = "The name of the consumer virtual machine"
}
variable "consumer_vm_size" {
  type = string
  description = "The size of the consumer virtual machine"
}

# Link between provider and consumer
variable "private_service_connection_name" {
  description = "The name of the private link service created by the provider"
  type        = string
}

variable "consumer_private_endpoint_name" {
  description = "The name of the private endpoint created by the consumer"
  type        = string
}
