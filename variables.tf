variable "container_group_name" {
  default       = "msaci"
  description   = "The name of the container group"
}

variable "resource_group_name" {
  default       = "ms"
  description   = "The name of the resource group"
}

variable "location" {
  default       = "South India"  
  description   = "Azure location"
}

variable "dns_name_label" {
  description   = "The DNS label/name for the container groups IP"
}

variable "os_type" {
  description   = "The OS for the container group. Allowed values are Linux and Windows"
}

variable "container_name" {
  default       = "ms2020acr"  
  description   = "The name of the container"
}

variable "image_name" {
  description   = "The container image name"
}

variable "cpu_core_number" {
  default       = "0.5"  
  description   = "The required number of CPU cores of the containers"
}

variable "memory_size" {
  default       = "1.5"  
  description   = "The required memory of the containers in GB"
}

variable "port_number" {
  default       = "80"  
  description   = "A public port for the container"
}