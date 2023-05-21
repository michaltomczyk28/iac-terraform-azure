resource "azurerm_resource_group" "tf_fun_rg" {
  name     = "rg-tffunctions"
  location = "North Europe"
}

resource "azurerm_storage_account" "tf_fun_sa" {
  name                     = "satffunctions"
  resource_group_name      = azurerm_resource_group.tf_fun_rg.name
  location                 = azurerm_resource_group.tf_fun_rg.location
  account_tier             = "Standard"
  account_replication_type = "GRS"
}