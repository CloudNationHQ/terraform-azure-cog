module "naming" {
  source  = "cloudnationhq/naming/azure"
  version = "~> 0.24"

  suffix = ["demo", "dev"]
}

module "rg" {
  source  = "cloudnationhq/rg/azure"
  version = "~> 2.0"

  groups = {
    demo = {
      name     = module.naming.resource_group.name_unique
      location = "swedencentral"
    }
  }
}

module "cognitiveservices" {
  source  = "cloudnationhq/cog/azure"
  version = "~> 2.0"

  account = {
    name                       = module.naming.cognitive_account.name_unique
    resource_group_name        = module.rg.groups.demo.name
    location                   = module.rg.groups.demo.location
    sku_name                   = "S0"
    kind                       = "AIServices"
    custom_subdomain_name      = module.naming.cognitive_account.name_unique
    project_management_enabled = true

    identity = {
      type = "SystemAssigned"
    }

    projects = {
      demo = {
        identity = {
          type = "SystemAssigned"
        }
      }
    }
  }
}
