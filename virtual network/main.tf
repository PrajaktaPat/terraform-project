resource "azurerm_virtual_network" "vnet" {
  name                = "${var.vnet-name}"
  resource_group_name = "${var.name}"
  location            = "${var.location}"
  address_space       = ["${var.address_space}"]
}

resource "azurerm_subnet" "subnets" {
  name                 = var.subnet_name[count.index]
  resource_group_name  = "${var.name}"
  virtual_network_name = "${azurerm_virtual_network.vnet.name}"
  address_prefixes  = [var.subnet_prefix[count.index]]
  count                 = length(var.subnet_prefix)
}
