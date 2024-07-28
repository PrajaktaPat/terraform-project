# Create a resource group
resource "azurerm_resource_group" "RG" {
  name     = var.name
  location = var.location
  tags = {
    Name= "${var.name}"
    ENV= "${var.env}"
  }
}


