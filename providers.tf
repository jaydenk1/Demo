terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "2.80.0"

    }
    http = {
      source = "hashicorp/http"
      version = "2.1.0"
    }
  }
}

provider "azurerm" {
  features {}
}