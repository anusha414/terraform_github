output "vm_public_ip" {
  description = "Public IP address of the virtual machine"
  value       = azurerm_virtual_machine.example.network_interface_ids[0].private_ip_address
}
