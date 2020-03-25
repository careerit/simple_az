provider "azurerm" {
    version = "~>2.1"
    features {}

}

resource "azurerm_resource_group" "main" {
    name = "${var.prefix}-ResourceGroup"
    location = var.location

}

resource "azurerm_virtual_network" "main" {
  name                = "${var.prefix}-main_network"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  address_space       = var.vnet_cidr


  subnet {
    name           = "public"
    address_prefix = "10.0.1.0/24"
  }


  tags = {
    Name = "abc"
    environment = "development"
  }
}

resource "azurerm_subnet" "public" {

  name                 = "default"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefix       = "10.0.2.0/24"

}