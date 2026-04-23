variable "resource_group_name" {
  type = string
}
variable "location" {
  type = string
}
variable "vmss_name" {
  type = string
}
variable "admin_username" {
  type = string
}

variable "admin_password" {
  type = string
}

variable "subnet_id" {
  type = string
}
variable "docker_username" {
  type = string
}
variable "docker_password" {
  type = string
}
variable "docker_image" {
  type = string
}
variable "cloud_init_script_path" {
  type = string
}

variable "application_name" {
  type = string
  description = "The name of the application to run in the Docker container"
}
variable "lb_backend_pool_id" {
  type = string
  description = "The ID of the load balancer backend pool to associate with the VMSS"
}

