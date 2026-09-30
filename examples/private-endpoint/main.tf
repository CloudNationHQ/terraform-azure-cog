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
    address_space       = ["10.19.0.0/16"]

    subnets = {
      sn1 = {
        name             = module.naming.subnet.name
        address_prefixes = ["10.19.1.0/24"]
        network_security_group = {
          name = module.naming.network_security_group.name
        }
      }
    }
  }
}

module "cognitiveservices" {
  source  = "cloudnationhq/cog/azure"
  version = "~> 3.0"

  location            = module.rg.groups.demo.location
  resource_group_name = module.rg.groups.demo.name

  account = {
    name                          = module.naming.cognitive_account.name_unique
    custom_subdomain_name         = module.naming.cognitive_account.name_unique
    kind                          = "AIServices"
    public_network_access_enabled = false
  }
}

module "private_dns" {
  source  = "cloudnationhq/pdns/azure"
  version = "~> 5.0"

  resource_group_name = module.rg.groups.demo.name

  zones = {
    private = {
      ai = {
        name = "privatelink.services.ai.azure.com"
        virtual_network_links = {
          link1 = {
            virtual_network_id = module.network.vnet.id
          }
        }
      }
    }
  }
}

module "privatelink" {
  source  = "cloudnationhq/pe/azure"
  version = "~> 3.0"

  resource_group_name = module.rg.groups.demo.name
  location            = module.rg.groups.demo.location

  endpoints = {
    cog = {
      name      = module.naming.private_endpoint.name
      subnet_id = module.network.subnets.sn1.id

      private_dns_zone_group = {
        private_dns_zone_ids = [module.private_dns.private_zones.ai.id]
      }

      private_service_connection = {
        private_connection_resource_id = module.cognitiveservices.account.id
        subresource_names              = ["account"]
      }
    }
  }
}
