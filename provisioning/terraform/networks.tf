##region-01============
resource "azurerm_virtual_network" "region-01" {
  name                = "${var.prefix}-vnet-region-01"
  address_space       = ["10.${var.region_octets[0]}.0.0/16"]
  location            = var.location_01
  resource_group_name = azurerm_resource_group.main.name

}
resource "azurerm_subnet" "region-01-public01" {
  name                 = "public01"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.region-01.name
  address_prefixes       = ["10.${var.region_octets[0]}.${var.subnet_octets[0]}.0/24"]
}

resource "azurerm_subnet" "region-01-azurebastionsubnet" {
  name                 = "AzureBastionSubnet"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.region-01.name
  address_prefixes       = ["10.${var.region_octets[0]}.${var.subnet_octets[2]}.0/24"]
}

#region-02==========================
resource "azurerm_virtual_network" "region-02" {
  name                = "${var.prefix}-vnet-region-02"
  address_space       = ["10.${var.region_octets[1]}.0.0/16"]
  location            = var.location_02
  resource_group_name = azurerm_resource_group.main.name
}
resource "azurerm_subnet" "region-02-public01" {
  name                 = "public01"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.region-02.name
  address_prefixes       = ["10.${var.region_octets[1]}.${var.subnet_octets[0]}.0/24"]
}

resource "azurerm_subnet" "region-02-azurebastionsubnet" {
  name                 = "AzureBastionSubnet"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.region-02.name
  address_prefixes       = ["10.${var.region_octets[1]}.${var.subnet_octets[2]}.0/24"]
}


#region-03==========================
resource "azurerm_virtual_network" "region-03" {
  name                = "${var.prefix}-vnet-region-03"
  address_space       = ["10.${var.region_octets[2]}.0.0/16"]
  location            = var.location_03
  resource_group_name = azurerm_resource_group.main.name
}
resource "azurerm_subnet" "region-03-public01" {
  name                 = "public01"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.region-03.name
  address_prefixes       = ["10.${var.region_octets[2]}.${var.subnet_octets[0]}.0/24"]
}

resource "azurerm_subnet" "region-03-azurebastionsubnet" {
  name                 = "AzureBastionSubnet"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.region-03.name
  address_prefixes       = ["10.${var.region_octets[2]}.${var.subnet_octets[2]}.0/24"]
}

