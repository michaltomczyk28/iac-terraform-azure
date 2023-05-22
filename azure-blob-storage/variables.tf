variable "resource_group_name" {
  type    = string
  default = "rg-blob-storage"
}

variable "resource_group_location" {
  type    = string
  default = "North Europe"
}

variable "storage_account_name" {
  type    = string
  default = "satfblobstorage001"
}

variable "account_tier" {
  type    = string
  default = "Standard"
}

variable "account_replication_type" {
  type    = string
  default = "GRS"
}

variable "storage_container_name" {
  type    = string
  default = "content"
}

variable "storage_container_access_type" {
  type    = string
  default = "private"
}

variable "storage_blob_name" {
  type    = string
  default = "content.png"
}

variable "storage_blob_type" {
  type    = string
  default = "Block"
}

variable "storage_blob_source" {
  type    = string
  default = "source.png"
}