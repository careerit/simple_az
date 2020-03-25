
resource "azurerm_network_interface" "main" {
  count               = 3 
  name                = "main-nic-${count.index}"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.public.id
    private_ip_address_allocation = "Dynamic"

  }
}

resource "azurerm_linux_virtual_machine" "main" {
  count               = 3
  name                = "main-machine-${count.index}"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  size                = "Standard_F2"
  admin_username      = "adminuser"
  admin_password      = var.password
  network_interface_ids = [element(azurerm_network_interface.main.*.id , "${count.index}")]
  disable_password_authentication = "false"
//   admin_ssh_key {
//     username   = "adminuser"
//     public_key = file("~/.ssh/id_rsa.pub")
//   }main

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }
}


// output "vm_private_ip" {

//     value = azurerm_linux_virtual_machine.main.private_ip_address

// }



