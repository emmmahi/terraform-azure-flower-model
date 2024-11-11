output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}

output "static_website_path" {
  value = azurerm_storage_account.flowersite.primary_web_host
}