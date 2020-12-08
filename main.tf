# Configure the Azure Provider
provider "azurerm" {
  # whilst the `version` attribute is optional, we recommend pinning to a given version of the Provider
  version = "=2.20.0"
  features {}
}

# Create a resource group
resource "azurerm_resource_group" "ms" {
  name     = "ms"
  location = "South India"
}
resource "azurerm_container_registry" "ms2020acr" {
  name                     = "ms2020acr"
  resource_group_name      = azurerm_resource_group.ms.name
  location                 = azurerm_resource_group.ms.location
  sku                      = "Basic"
  admin_enabled            = true
}

output "admin_password" {
  value       = azurerm_container_registry.ms2020acr.admin_password
  description = "The object ID of the user"
}


resource "azurerm_container_group" "msaci" {
  name                  = "${var.container_group_name}"
  resource_group_name   = "${azurerm_resource_group.ms.name}"
  location              = "${azurerm_resource_group.ms.location}"
  ip_address_type       = "public"
  dns_name_label        = "${var.dns_name_label}"
  os_type               = "${var.os_type}"

  container {
      name      = "${var.container_name}"
      image     = "${var.image_name}"
      cpu       = "${var.cpu_core_number}"
      memory    = "${var.memory_size}"
      port      = "${var.port_number}"
  }
}

output "containergroup_id" {
  description = "The ID of the created container group"
  value       = "${azurerm_container_group.containergroup.id}"
}

output "containergroup_ip_address" {
  description = "The IP address of the created container group"
  value       = "${azurerm_container_group.containergroup.ip_address}"
}

output "containergroup_fqdn" {
  description = "The FQDN of the created container group"
  value       = "${azurerm_container_group.containergroup.fqdn}"
}

/*# 
module "aci" {
  source                = "Azure/aci/azurerm"
  resource_group_name   = "ms"
  location              = "West Europe"
  container_group_name  = "ms"
  dns_name_label        = "mediawiki"
  os_type               = "linux"
  image_name            = "ms2020acr.azurecr.io/mediawiki:v1"
  container_name        = "ms01"
  cpu_core_number       = "0.5"
  memory_size           = "1.5"
  port_number           = "80"
}
variable "resource_group_name" {
  default = "test-aci-rg01"
}


module "aci" {
  source                = "Azure/aci/azurerm"
  dns_name_label        = "mediawiki"
  os_type               = "linux"
  image_name            = "mediawiki:v1"
  resource_group_name   = "${var.resource_group_name}"
}

output "fqdn" {
  value = "${module.aci.containergroup_fqdn}"
}

output "ip" {
  value = "${module.aci.containergroup_ip_address}"
}

output "id" {
  value = "${module.aci.containergroup_id}"
}
*/