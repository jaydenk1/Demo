output "tls_private_key" {
  value     = tls_private_key.example_ssh.private_key_pem
  sensitive = true
}

output "public_ip_address" {
  value = azurerm_public_ip.public_ip.ip_address
}
