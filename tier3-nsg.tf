resource "azurerm_network_security_group" "tier3_fw" {
  name                = "sql_fw"
  location            = "${azurerm_resource_group.ResourceGrps.location}"
  resource_group_name = "${azurerm_resource_group.ResourceGrps.name}"

  security_rule {
    name                       = "allow-sql"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "1433"
    source_address_prefix      = "10.0.2.0/24"
    destination_address_prefix = "10.0.3.0/24"
  }

  security_rule {
    name                       = "allow-winrm"
    priority                   = 101
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "5985-5986"
    source_address_prefix      = "*"
    destination_address_prefix = "10.0.3.0/24"
  }

  security_rule {
    name                       = "allow-RDP"
    priority                   = 102
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "10.0.3.0/24"
    destination_address_prefix = "10.0.0.128/25"
  }

  security_rule {
    name                       = "Deny-tier1-HTTP"
    priority                   = 200
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "Tcp"
    source_port_range          = "80"
    destination_port_range     = "50"
    source_address_prefix      = "10.0.1.0/24"
    destination_address_prefix = "10.0.3.0/24"
  }

  security_rule {
    name                       = "Deny-tier2-HTTP"
    priority                   = 210
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "Tcp"
    source_port_range          = "80"
    destination_port_range     = "50"
    source_address_prefix      = "10.0.2.0/24"
    destination_address_prefix = "10.0.3.0/24"
  }
}
