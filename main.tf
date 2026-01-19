terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "=4.0.0"
    }
  }
}
/*
provider "azurerm" {
  #resource_provider_registrations = "none" # This is only required when the User, Service Principal, or Identity running Terraform lacks the permissions to register Azure Resource Providers.
  features {}
  client_id = 55f5a120-b536-40aa-b9b1-88bb8a101048
  tenant_id = 518b32b2-b122-43e7-a766-960beb7499f3
  client_secret = D2A8Q~tCnTiQytGEyg6jPgXIgwgoXeiFh1Cntbge
  subscription_id = 9f1d9528-b481-43e9-9ac6-aa5ee102f2ff
}

terraform {
  backend "azurerm" {
  access_key           = "kNm8tvv3Eqz+FuYOi3qJBxzdtDuUuSpbUmGKz7Qgu1YmcGLqUSZnzEa+4WPuyLguYmG46ueMobEX+ASt/8Epuw=="  # Can also be set via `ARM_ACCESS_KEY` environment variable.
    storage_account_name = "backendstr01"                                 # Can be passed via `-backend-config=`"storage_account_name=<storage account name>"` in the `init` command.
    container_name       = "tfstate"                                  # Can be passed via `-backend-config=`"container_name=<container name>"` in the `init` command.
    key                  = "terraform.tfstate"                   # Can be passed via `-backend-config=`"key=<blob key name>"` in the `init` command.
  }
}

resource "azurerm_resource_group" "rg" {
  name = "${var.rgname}"
  location = "${var.rglocation}"
}
*/
locals {
   env = "dev"
}

resource "azurerm_resource_group" "rg" {
  name = "${local.env}_datarg"
  location = "${var.rglocation}"
}
/*
resource "azurerm_virtual_network" "vnet" {
    name = "${var.prefix}"
    location = "${data.azurerm_resource_group.rg.location}"
    resource_group_name = "${data.azurerm_resource_group.rg.name}"
    address_space = ["${var.vnet_cidr_prefix}"]

}
resource "azurerm_subnet" "sub1" {
    name = "${var.prefix}-sub1"
    virtual_network_name = "${azurerm_virtual_network.vnet.name}"
    resource_group_name =  "${data.azurerm_resource_group.rg.name}"
   address_prefixes = [ "${var.subnet_cidr_prefix}" ]
}

resource "azurerm_network_interface" "nic" {
    name = "${var.nic}"
    location = "${azurerm_resource_group.rg.location}"
    resource_group_name = "${var.rgname}"
    ip_configuration {
        name = "${var.nic}"
        subnet_id  = azurerm_subnet.sub1.id
        private_ip_address_allocation = "Dynamic"
    }
  
}
resource "azurerm_network_interface_security_group_association" "nsg_asso" {
    #subnet_id                 = azurerm_subnet.sub1.id
    network_security_group_id = azurerm_network_security_group.nsg1.id
    network_interface_id = azurerm_network_interface.nic.id
}

resource "azurerm_network_security_group" "nsg1" {
  name                = "${var.nsg}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  security_rule {
    name                       = "test123"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

/*
resource "azurerm_windows_virtual_machine" "vm1" {
  name                = "terra-machine"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  size                = "Standard_F2"
  admin_username      = "adminuser"
  admin_password      = "P@ss1234"
  network_interface_ids = [
    azurerm_network_interface.nic.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }
}
*/
resource "azurerm_app_service_plan" "app-plan" {
  name                = "webapp-appserviceplan"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  sku {
    tier = "Free"
    size = "F1"
  }

}

resource "azurerm_app_service" "webapp" {
  name                = "web1-app-service"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  app_service_plan_id = azurerm_app_service_plan.app-plan.id

}


/*
  site_config {
    dotnet_framework_version = "v4.0"
    scm_type                 = "LocalGit"

  }

  connection_string {
    name  = "Database"
    type  = "SQLServer"
    value = "Server=some-server.mydomain.com;Integrated Security=SSPI"
  }
*/
