variable "resource_group_name" {
  type    = string
  default = "rg-appservice"
}

variable "resource_group_location" {
  type    = string
  default = "North Europe"
}

variable "app_service_plan_name" {
  type    = string
  default = "plan-appservice"
}

variable "app_service_plan_sku_tier" {
  type    = string
  default = "Standard"
}

variable "app_service_plan_sku_size" {
  type    = string
  default = "S1"
}

variable "app_service_name" {
  type    = string
  default = "app-appservice"
}

variable "python_version" {
  type    = string
  default = "3.4"
}