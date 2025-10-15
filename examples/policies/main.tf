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
      location = "westeurope"
    }
  }
}

module "cognitiveservices" {
  source  = "cloudnationhq/cog/azure"
  version = "~> 2.0"

  naming = local.naming

  account = {
    name                = module.naming.cognitive_account.name_unique
    resource_group_name = module.rg.groups.demo.name
    location            = module.rg.groups.demo.location
    sku_name            = "S0"
    kind                = "OpenAI"

    deployments = {
      gpt-4o = {
        model = {
          format  = "OpenAI"
          name    = "gpt-4o"
          version = "2024-08-06"
        }
        sku = {
          name     = "DataZoneStandard"
          capacity = 100
        }
      }
    }
    policies = {
      example = {
        base_policy_name = "Microsoft.Default"
        content_filters = {
          filter_hate = {
            name               = "Hate"
            filter_enabled     = true
            block_enabled      = true
            severity_threshold = "High"
            source             = "Prompt"
          }
          filter_violence = {
            name               = "Violence"
            filter_enabled     = true
            block_enabled      = true
            severity_threshold = "Low"
            source             = "Completion"
          }
        }
      }
    }
  }
}
