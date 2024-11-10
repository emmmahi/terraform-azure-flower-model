# määrittelee azurerm provderin ja version
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
  }
}

#aktivoi  azurerm providerin ominaiuudet
provider "azurerm" {
  features {}
}