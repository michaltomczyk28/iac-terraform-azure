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

resource "azurerm_app_service_plan" "tf_fun_asp" {
  name                = "asp-tffunctions"
  location            = azurerm_resource_group.tf_fun_rg.location
  resource_group_name = azurerm_resource_group.tf_fun_rg.name

  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_linux_function_app" "tf_fun_lfa" {
  name                = "func-tffunctions-linux"
  resource_group_name = azurerm_resource_group.tf_fun_rg.name
  location            = azurerm_resource_group.tf_fun_rg.location

  storage_account_name       = azurerm_storage_account.tf_fun_sa.name
  storage_account_access_key = azurerm_storage_account.tf_fun_sa.primary_access_key
  service_plan_id            = azurerm_app_service_plan.tf_fun_asp.id

  site_config {}
}