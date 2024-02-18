# We strongly recommend using the required_providers block to set the
# Azure Provider source and version being used
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  # skip_provider_registration = true # This is only required when the User, Service Principal, or Identity running Terraform lacks the permissions to register Azure Resource Providers.
  features {}
}

# Create a resource group
resource "azurerm_resource_group" "main_rg" {
  name     = var.rg_name
  location = var.location
  tags     = var.tags
}

resource "azurerm_virtual_network" "main_vnet" {
  name                = "Terraform_VNET"
  location            = azurerm_resource_group.main_rg.location
  resource_group_name = azurerm_resource_group.main_rg.name
  address_space       = [var.vnet_address_space]

  subnet {
    name           = var.subnet_names[0]
    address_prefix = var.subnet_addresses[0]
  }

  subnet {
    name           = var.subnet_names[1]
    address_prefix = var.subnet_addresses[1]
  }
}

resource "azurerm_subnet" "main_vnet_subnets" {
  for_each             = var.subnets
  resource_group_name  = azurerm_resource_group.main_rg.name
  virtual_network_name = azurerm_virtual_network.main_vnet.name
  name                 = each.key
  address_prefixes     = each.value["address"]
}

resource "azurerm_public_ip" "dev01vm_pub_ip" {
  name                = "dev01vm-ip"
  resource_group_name = azurerm_resource_group.main_rg.name
  location            = azurerm_resource_group.main_rg.location
  allocation_method   = "Dynamic"

}

resource "azurerm_network_interface" "dev01vm_nic" {
  name                = "dev01vm-nic"
  location            = azurerm_resource_group.main_rg.location
  resource_group_name = azurerm_resource_group.main_rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_virtual_network.main_vnet.subnet.*.id[0]
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.dev01vm_pub_ip.id
  }
}

resource "azurerm_network_security_group" "nsg_ssh" {
  name                = "dev01vm-nsg"
  location            = azurerm_resource_group.main_rg.location
  resource_group_name = azurerm_resource_group.main_rg.name

  security_rule {
    name                       = "SSH"
    priority                   = 300
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}
resource "azurerm_network_interface_security_group_association" "nsg_association" {
  network_interface_id      = azurerm_network_interface.dev01vm_nic.id
  network_security_group_id = azurerm_network_security_group.nsg_ssh.id
}

resource "azurerm_linux_virtual_machine" "dev01vm" {
  name                = var.vm_name
  resource_group_name = azurerm_resource_group.main_rg.name
  location            = azurerm_resource_group.main_rg.location
  size                = "Standard_B2s"

  network_interface_ids = [
    azurerm_network_interface.dev01vm_nic.id,
  ]
  admin_username = "azureuser"
  admin_ssh_key {
    username   = "azureuser"
    public_key = file("C:/Users/piotr/.ssh/id_rsa.pub")
  }

  disable_password_authentication = !var.enable_password_authentication

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }
}
output "public_ip" {
  value = azurerm_public_ip.dev01vm_pub_ip.ip_address
}