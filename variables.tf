variable "vm_name" {
  description = "Name of the virtual machine"
  type        = string
}

variable "vm_size" {
  description = "Size of the virtual machine (e.g., Standard_DS1_v2)"
  type        = string
}

variable "vm_username" {
  description = "Username for logging into the virtual machine"
  type        = string
}

variable "vm_password" {
  description = "Password for logging into the virtual machine"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group where the VM will be deployed"
  type        = string
}

variable "location" {
  description = "Location/Region where the VM will be deployed (e.g., East US)"
  type        = string
}
