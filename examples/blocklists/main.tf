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
      location = "westeurope"
    }
  }
}

module "cognitiveservices" {
  source  = "cloudnationhq/cog/azure"
  version = "~> 3.0"

  account = {
    name                = module.naming.cognitive_account.name_unique
    resource_group_name = module.rg.groups.demo.name
    location            = module.rg.groups.demo.location
    sku_name            = "S0"
    kind                = "OpenAI"

    deployments = {
      gpt-4o = {
        model = {
          format = "OpenAI"
          name   = "gpt-4o"
        }
        sku = {
          name     = "DataZoneStandard"
          capacity = 100
        }
      }
    }
    blocklists = {
      harmful_content = {
        name        = "harmful-content-blocklist"
        description = "Blocks harmful content including hate speech and violence"
      },
      personal_info = {
        name        = "personal-info-blocklist"
        description = "Blocks personal identifiable information"
      },
      custom_terms = {
        description = "Custom terms and phrases to block"
      }
    }
  }
}
