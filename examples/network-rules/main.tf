module "naming" {
  source  = "cloudnationhq/naming/azure"
  version = "~> 0.32"

  suffix = ["demo", "dev"]
}

module "rg" {
  source  = "cloudnationhq/rg/azure"
  version = "~> 3.0"

  groups = {
    demo = {
      name     = module.naming.resource_group.name_unique
      location = "swedencentral"
    }
  }
}

module "network" {
  source  = "cloudnationhq/vnet/azure"
  version = "~> 10.0"

  vnet = {
    name                = module.naming.virtual_network.name
    location            = module.rg.groups.demo.location
    resource_group_name = module.rg.groups.demo.name
    address_space       = ["10.20.0.0/16"]

    subnets = {
      sn1 = {
        name              = module.naming.subnet.name
        address_prefixes  = ["10.20.1.0/24"]
        service_endpoints = ["Microsoft.CognitiveServices"]
      }
    }
  }
}

module "cognitiveservices" {
  source  = "cloudnationhq/cog/azure"
  version = "~> 3.0"

  account = {
    name                  = module.naming.cognitive_account.name_unique
    resource_group_name   = module.rg.groups.demo.name
    location              = module.rg.groups.demo.location
    kind                  = "OpenAI"
    custom_subdomain_name = module.naming.cognitive_account.name_unique

    network_acls = {
      default_action = "Deny"
      bypass         = "AzureServices"
      ip_rules       = ["203.0.113.0/24"]
      virtual_network_rules = {
        sn1 = {
          subnet_id = module.network.subnets.sn1.id
        }
      }
    }
  }
}
