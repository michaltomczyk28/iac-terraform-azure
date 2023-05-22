resource "azurerm_resource_group" "tf_fun_rg" {
  name     = var.resource_group_name
  location = var.resource_group_location
}

resource "azurerm_storage_account" "tf_fun_sa" {
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.tf_fun_rg.name
  location                 = azurerm_resource_group.tf_fun_rg.location
  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type
}

resource "azurerm_app_service_plan" "tf_fun_asp" {
  name                = var.app_service_plan_name
  location            = azurerm_resource_group.tf_fun_rg.location
  resource_group_name = azurerm_resource_group.tf_fun_rg.name
  kind                = var.app_service_plan_kind
  reserved            = var.app_service_plan_reserved

  sku {
    tier = var.app_service_plan_sku_tier
    size = var.app_service_plan_sku_size
  }
}

resource "azurerm_linux_function_app" "tf_fun_lfa" {
  name                = var.linux_function_app_name
  resource_group_name = azurerm_resource_group.tf_fun_rg.name
  location            = azurerm_resource_group.tf_fun_rg.location

  storage_account_name       = azurerm_storage_account.tf_fun_sa.name
  storage_account_access_key = azurerm_storage_account.tf_fun_sa.primary_access_key
  service_plan_id            = azurerm_app_service_plan.tf_fun_asp.id

  site_config {
    application_stack {
      python_version = var.python_version
    }
  }
}

resource "azurerm_function_app_function" "tf_fun_faf" {
  name            = var.function_app_function_name
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