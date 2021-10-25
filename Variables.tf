variable "location" {
  description = "region location"
  type        = string
}
variable "resource_group_name" {
  description = "resource group name"
  type        = string
}

variable "virtual_network" {
  description = "name of VNET"
  type        = string
}

variable "address_space" {
  description = "Virtual network Addresss space"
  type        = list
}

variable "address_prefixes" {
  description = "Subnet address prefix"
  type        = list
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