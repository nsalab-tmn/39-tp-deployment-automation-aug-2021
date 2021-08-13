##region-01============
resource "azurerm_network_interface" "platform-region-01-public" {
  name                = "platform-region-01"
  location            = var.location_01
  resource_group_name = azurerm_resource_group.main.name

  ip_configuration {
    name                          = "public"
    subnet_id                     = azurerm_subnet.region-01-public01.id
    private_ip_address_allocation = "Static" #have to be Dynamic according to template. why?
    private_ip_address_version    = "IPv4"
    primary                       = true
    private_ip_address            = "10.${var.region_octets[0]}.${var.subnet_octets[0]}.${var.host_octets[0]}"
    public_ip_address_id          = azurerm_public_ip.platform-region-01.id
  }
}

resource "azurerm_public_ip" "platform-region-01" {
  name                    = "platform-region-01"
  location                = var.location_01
  resource_group_name     = azurerm_resource_group.main.name
  sku                     = "Basic"
  allocation_method       = "Static"
  ip_version              = "IPv4"
  idle_timeout_in_minutes = 4
}



resource "azurerm_linux_virtual_machine" "platform-region-01" {
  name                            = "platform-region-01"
  resource_group_name             = azurerm_resource_group.main.name
  location                        = var.location_01
  size                            = "Standard_B2s"
  admin_username                  = var.adminuser
  admin_password                  = random_string.pass.result
  disable_password_authentication = false
  provision_vm_agent              = true


  allow_extension_operations = true
  computer_name              = "platform-region-01"
  network_interface_ids = [
    azurerm_network_interface.platform-region-01-public.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "StandardSSD_LRS"
    disk_size_gb         = 30
    name                 = "platform-region-01"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts"
    version   = "latest"
  }
  # custom_data = var.deploy_custom_data ? base64encode(templatefile("${path.module}/${var.assets_path}/customdata-platform-region-01.tpl", {
  #   prefix="${var.competition_instance}-${var.prefix}",platform_01_ip=azurerm_network_interface.platform-region-01.private_ip_address,
  #   platform_02_ip=azurerm_network_interface.platform-region-02.private_ip_address,
  #   platform_03_ip=azurerm_network_interface.platform-region-03.private_ip_address})):null
}

##region-02============
resource "azurerm_network_interface" "platform-region-02-public" {
  name                = "platform-region-02-public"
  location            = var.location_02
  resource_group_name = azurerm_resource_group.main.name

  ip_configuration {
    name                          = "public"
    subnet_id                     = azurerm_subnet.region-02-public01.id
    private_ip_address_allocation = "Static" #have to be Dynamic according to template. why?
    private_ip_address_version    = "IPv4"
    primary                       = true
    private_ip_address            = "10.${var.region_octets[1]}.${var.subnet_octets[0]}.${var.host_octets[0]}"
    public_ip_address_id          = azurerm_public_ip.platform-region-02.id
  }
}

resource "azurerm_public_ip" "platform-region-02" {
  name                    = "platform-region-02-public"
  location                = var.location_02
  resource_group_name     = azurerm_resource_group.main.name
  sku                     = "Basic"
  allocation_method       = "Static"
  ip_version              = "IPv4"
  idle_timeout_in_minutes = 4
}

resource "azurerm_linux_virtual_machine" "platform-region-02" {
  name                            = "platform-region-02"
  resource_group_name             = azurerm_resource_group.main.name
  location                        = var.location_02
  size                            = "Standard_B1s"
  admin_username                  = var.adminuser
  admin_password                  = random_string.pass.result
  disable_password_authentication = false
  provision_vm_agent              = true


  allow_extension_operations = true
  computer_name              = "platform-region-02"
  network_interface_ids = [
    azurerm_network_interface.platform-region-02-public.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "StandardSSD_LRS"
    disk_size_gb         = 30
    name                 = "platform-region-02"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts"
    version   = "latest"
  }
  # custom_data = var.deploy_custom_data ? base64encode(templatefile("${path.module}/${var.assets_path}/customdata-platform-region-02.tpl", {
  #   prefix="${var.competition_instance}-${var.prefix}",platform_01_ip=azurerm_network_interface.platform-region-01.private_ip_address,
  #   platform_02_ip=azurerm_network_interface.platform-region-02.private_ip_address,
  #   platform_03_ip=azurerm_network_interface.platform-region-03.private_ip_address})):null
}

##region-03============
resource "azurerm_network_interface" "platform-region-03-public" {
  name                = "platform-region-03-public"
  location            = var.location_03
  resource_group_name = azurerm_resource_group.main.name

  ip_configuration {
    name                          = "public"
    subnet_id                     = azurerm_subnet.region-03-public01.id
    private_ip_address_allocation = "Static" #have to be Dynamic according to template. why?
    private_ip_address_version    = "IPv4"
    primary                       = true
    private_ip_address            = "10.${var.region_octets[2]}.${var.subnet_octets[0]}.${var.host_octets[0]}"
    public_ip_address_id          = azurerm_public_ip.platform-region-03.id
  }
}

resource "azurerm_public_ip" "platform-region-03" {
  name                    = "platform-region-03-public"
  location                = var.location_03
  resource_group_name     = azurerm_resource_group.main.name
  sku                     = "Basic"
  allocation_method       = "Static"
  ip_version              = "IPv4"
  idle_timeout_in_minutes = 4
}




resource "azurerm_linux_virtual_machine" "platform-region-03" {
  name                            = "platform-region-03"
  resource_group_name             = azurerm_resource_group.main.name
  location                        = var.location_03
  size                            = "Standard_B1ms"
  admin_username                  = var.adminuser
  admin_password                  = random_string.pass.result
  disable_password_authentication = false
  provision_vm_agent              = true


  allow_extension_operations = true
  computer_name              = "platform-region-03"
  network_interface_ids = [
    azurerm_network_interface.platform-region-03-public.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "StandardSSD_LRS"
    disk_size_gb         = 30
    name                 = "platform-region-03"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
  # custom_data = var.deploy_custom_data ? base64encode(templatefile("${path.module}/${var.assets_path}/customdata-platform-region-03.tpl", {
  #   prefix="${var.competition_instance}-${var.prefix}",platform_01_ip=azurerm_network_interface.platform-region-01.private_ip_address,
  #   platform_02_ip=azurerm_network_interface.platform-region-02.private_ip_address,
  #   platform_03_ip=azurerm_network_interface.platform-region-03.private_ip_address})):null
}

resource "null_resource" "params" {
  provisioner "local-exec" {
    command = "terraform output -json dynamic-params | jq > tf-dynamic-params.json"    
  }
  depends_on = [    
    azurerm_linux_virtual_machine.platform-region-01,
    azurerm_linux_virtual_machine.platform-region-02,
    azurerm_linux_virtual_machine.platform-region-03
  ]
}