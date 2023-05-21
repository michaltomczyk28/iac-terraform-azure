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
  kind                = "Linux"
  reserved            = true

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

  site_config {
    application_stack {
      python_version = "3.9"
    }
  }
}

resource "azurerm_function_app_function" "tf_fun_faf" {
  name            = "func-tffunctions-function"
  function_app_id = azurerm_linux_function_app.tf_fun_lfa.id
  language        = "Python"

  file {
    name    = "__init__.py"
    content = file("./function.py")
  }

  config_json = jsonencode({
    "bindings" = [
      {
        "authLevel" = "function"
        "direction" = "in"
        "methods" = [
          "get",
          "post",
        ]
        "name" = "req"
        "type" = "httpTrigger"
      },
      {
        "direction" = "out"
        "name"      = "$return"
        "type"      = "http"
      },
    ]
  })
}