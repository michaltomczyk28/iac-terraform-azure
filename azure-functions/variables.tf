variable "resource_group_name" {
  type    = string
  default = "rg-functions"
}

variable "resource_group_location" {
  type    = string
  default = "North Europe"
}

variable "storage_account_name" {
  type    = string
  default = "satffunctions001"
}

variable "account_tier" {
  type    = string
  default = "Standard"
}

variable "account_replication_type" {
  type    = string
  default = "GRS"
}

variable "app_service_plan_name" {
  type    = string
  default = "plan-functions"
}

variable "app_service_plan_kind" {
  type    = string
  default = "Linux"
}

variable "app_service_plan_reserved" {
  type    = bool
  default = true
}

variable "app_service_plan_sku_tier" {
  type    = string
  default = "Standard"
}

variable "app_service_plan_sku_size" {
  type    = string
  default = "S1"
}

variable "linux_function_app_name" {
  type    = string
  default = "fapp-functions"
}

variable "python_version" {
  type    = string
  default = "3.9"
}

variable "function_app_function_name" {
  type    = string
  default = "func-functions"
}
