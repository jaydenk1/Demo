variable "location" {
  description = "region location"
  type        = string
  default     = "australiaeast"
}

variable "resource_group_name" {
  description = "resource group name"
  type        = string
  default     = "RG-Qrious"
}



variable "azurerm_virtual_network" {
  description = "name of VNET"
  type        = string
  default     = "Qrious"
}


variable "vm_name" {
  description = "name of VM"
  type        = string
  default     = "Vmb1s"

}


variable "adminusername" {
  description = "username credential for Vmb1s"
  type        = string
  default     = "Qriousadmin"

}







