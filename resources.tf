resource "tls_private_key" "example_ssh" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Create a resource group
resource "azurerm_resource_group" "rgroup01" {
  name     = var.resource_group_name
  location = var.location
}

# Create a virtual network within the resource group
resource "azurerm_virtual_network" "azvnet" {
  name                = "${var.virtual_network}-vnet"
  location            = var.location
  address_space       = var.address_space
  resource_group_name = azurerm_resource_group.rgroup01.name
}
resource "azurerm_subnet" "subnet" {
  name                 = "${var.virtual_network}-snet01"
  address_prefixes     = var.address_prefixes
  resource_group_name  = azurerm_resource_group.rgroup01.name
  virtual_network_name = azurerm_virtual_network.azvnet.name
}

# Create NSG to allow port 80, 443, 22 & All outbound 
resource "azurerm_network_security_group" "nsg" {
  name                = "QriousNSG"
  location            = azurerm_resource_group.rgroup01.location
  resource_group_name = azurerm_resource_group.rgroup01.name

  security_rule {
    name                       = "Allow Web Server and SSH"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_ranges    = [80, 443, 22, 8080]
    source_address_prefix      = "${chomp(data.http.icanhazip.body)}"
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "Block Everything Else"
    priority                   = 200
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_subnet_network_security_group_association" "nsgassociation" {
  subnet_id                 = azurerm_subnet.subnet.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}


#create static public IP 
resource "azurerm_public_ip" "public_ip" {
  name                = "${var.vm_name}-vm-pip"
  location            = var.location
  resource_group_name = azurerm_resource_group.rgroup01.name
  allocation_method   = "Static"
  domain_name_label   = "qrious"
}

#create network NIC
resource "azurerm_network_interface" "vm_nic" {
  name                = "${var.vm_name}-vm-nic"
  location            = var.location
  resource_group_name = azurerm_resource_group.rgroup01.name

  ip_configuration {
    name                          = "primary"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.public_ip.id

  }
}

resource "azurerm_linux_virtual_machine" "simple-vm" {
  name                = var.vm_name
  resource_group_name = azurerm_resource_group.rgroup01.name
  location            = azurerm_resource_group.rgroup01.location
  size                = "Standard_B1s"
  admin_username      = var.adminusername
  network_interface_ids = [
    azurerm_network_interface.vm_nic.id,
  ]

  admin_ssh_key {
    username   = var.adminusername
    public_key = tls_private_key.example_ssh.public_key_openssh
  }

  os_disk {
    name                 = "myOSDisk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

   provisioner "file" {
    source      = "./scripts"
    destination = "/tmp"
    connection {
      type        = "ssh"
      user        = var.adminusername
      private_key = tls_private_key.example_ssh.private_key_pem
      host        = azurerm_public_ip.public_ip.ip_address
    }
  }



  provisioner "remote-exec" {
    inline = [
      "sudo chmod +x /tmp/scripts/config.sh",
      "sudo sh /tmp/scripts/config.sh",
    ]

    connection {
      type        = "ssh"
      user        = var.adminusername
      private_key = tls_private_key.example_ssh.private_key_pem
      host        = azurerm_public_ip.public_ip.ip_address
    }
  }
}
