# resource groupin määritys, saa sijainnin ja nimi rakennetaan muuttujien avulla
resource "azurerm_resource_group" "rg" {
  location = var.resource_group_location
  name     = "${var.product}-rg-${var.suffix}"
}

# strorage account määritys, nimi tulee muuttujien kautta
# huomaa viittauksen vaadituun ylempään resurssiin 
resource "azurerm_storage_account" "flowersite" {
  name                     = "${var.product}${var.suffix}"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  static_website {
    index_document = "index.html"
  }
}

# luodaan blob storage kontti? joka tulee automaattisesti kun static website on ylemmässä käytössä
resource "azurerm_storage_blob" "index_html" {
  name                   = "index.html"
  storage_account_name   = azurerm_storage_account.flowersite.name
  storage_container_name = "$web"
  type                   = "Block"
  content_type           = "text/html"
  source                 = "index.html"
}

resource "azurerm_storage_blob" "style_css" {
  name                   = "style.css"
  storage_account_name   = azurerm_storage_account.flowersite.name
  storage_container_name = "$web"
  type                   = "Block"
  content_type           = "text/css"
  source                 = "style.css"
}

resource "azurerm_storage_blob" "script_js" {
  name                   = "script.js"
  storage_account_name   = azurerm_storage_account.flowersite.name
  storage_container_name = "$web"
  type                   = "Block"
  content_type           = "application/javascript"
  source                 = "script.js"
}

# model.json -tiedoston kopiointi Blob Storageen
resource "azurerm_storage_blob" "model_json" {
  name                   = "flower_tfjs_5/model.json"
  storage_account_name   = azurerm_storage_account.flowersite.name
  storage_container_name = "$web"
  type                   = "Block"
  content_type           = "application/json"
  source                 = "flower_tfjs_5/model.json"
}

# Ensimmäisen bin-tiedoston kopiointi Blob Storageen
resource "azurerm_storage_blob" "group1_shard1of3" {
  name                   = "flower_tfjs_5/group1-shard1of3.bin"
  storage_account_name   = azurerm_storage_account.flowersite.name
  storage_container_name = "$web"
  type                   = "Block"
  content_type           = "application/octet-stream"
  source                 = "flower_tfjs_5/group1-shard1of3.bin"
}

# Toisen bin-tiedoston kopiointi Blob Storageen
resource "azurerm_storage_blob" "group1_shard2of3" {
  name                   = "flower_tfjs_5/group1-shard2of3.bin"
  storage_account_name   = azurerm_storage_account.flowersite.name
  storage_container_name = "$web"
  type                   = "Block"
  content_type           = "application/octet-stream"
  source                 = "flower_tfjs_5/group1-shard2of3.bin"
}

# Kolmannen bin-tiedoston kopiointi Blob Storageen
resource "azurerm_storage_blob" "group1_shard3of3" {
  name                   = "flower_tfjs_5/group1-shard3of3.bin"
  storage_account_name   = azurerm_storage_account.flowersite.name
  storage_container_name = "$web"
  type                   = "Block"
  content_type           = "application/octet-stream"
  source                 = "flower_tfjs_5/group1-shard3of3.bin"
}