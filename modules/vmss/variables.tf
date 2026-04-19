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
