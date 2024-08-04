module "virtual_network" {
  source = "/Users/aniketchougule/Prajakta/azure-terraform-project/Terraform Infra/modules/virtual network/"
  name = var.name
  location = "${var.location}"
  vnet-name = "${var.vnet-name}"
  address_space = var.address_space

}
resource "azurerm_public_ip" "public_ip" {
   count                 = length(var.pubip)
   name                = "dev-public-ip-${var.pubip[count.index]}"
   location            = var.location
   resource_group_name = var.name
   allocation_method   = "Static"  # Use "Dynamic" if you want a dynamic IP

   tags = {
     ENV= "${var.env}"
  }
}


resource "azurerm_network_interface" "nic" {
  count                 = length(var.nicname) 
  name                = "dev4824-nic-${var.nicname[count.index]}"
  location            = var.location
  resource_group_name = var.name

  ip_configuration {
    name                          = "testconfiguration1-4824-${var.nicname[count.index]}"
    subnet_id                     = module.virtual_network.subnet_ids["appsubnet"]
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.public_ip[count.index].id
  }
}


# Define the virtual machine
resource "azurerm_linux_virtual_machine" "dev-vm" {
  count                 = length(var.nameVMs)
  name                  = var.nameVMs[count.index]
  resource_group_name   = var.name
  location              = var.location
  size                  = "Standard_B1s"  # Free tier VM size
  network_interface_ids = [azurerm_network_interface.nic[count.index].id]
  admin_username        = "adminuser"

  admin_ssh_key {
    username   = "adminuser"
    public_key = var.public_key
  }
  

  #os_profile_linux_config {
  #  disable_password_authentication = true
  #}

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    #name              = "myosdisk1"
    disk_size_gb      = 30
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  tags = {
    ENV= "${var.env}"
  }

}
