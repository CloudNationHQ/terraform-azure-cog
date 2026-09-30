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

module "storage" {
  source  = "cloudnationhq/sa/azure"
  version = "~> 5.0"

  storage = {
    name                = module.naming.storage_account.name_unique
    location            = module.rg.groups.demo.location
    resource_group_name = module.rg.groups.demo.name
  }
}

module "cosmosdb" {
  source  = "cloudnationhq/cosmosdb/azure"
  version = "~> 6.0"

  account = {
    name                = module.naming.cosmosdb_account.name_unique
    location            = module.rg.groups.demo.location
    resource_group_name = module.rg.groups.demo.name
    kind                = "GlobalDocumentDB"
    capabilities        = ["EnableServerless"]

    geo_location = {
      primary = {
        location          = module.rg.groups.demo.location
        failover_priority = 0
      }
    }

    consistency_policy = {
      consistency_level = "Session"
    }
  }
}

module "search" {
  source  = "cloudnationhq/srch/azure"
  version = "~> 2.0"

  search_service = {
    name                = module.naming.search_service.name_unique
    resource_group_name = module.rg.groups.demo.name
    location            = module.rg.groups.demo.location
    sku                 = "basic"
  }
}

module "cognitiveservices" {
  source  = "cloudnationhq/cog/azure"
  version = "~> 3.0"

  location            = module.rg.groups.demo.location
  resource_group_name = module.rg.groups.demo.name

  account = {
    name                       = module.naming.cognitive_account.name_unique
    custom_subdomain_name      = module.naming.cognitive_account.name_unique
    kind                       = "AIServices"
    project_management_enabled = true

    identity = {
      type = "SystemAssigned"
    }

    role_assignments = {
      developer = {
        role_definition_name = "Azure AI Developer"
      }
    }

    capability_host = {
      capability_host_kind = "Agents"
    }

    projects = {
      agent-project = {
        display_name = "Agent Project"
        description  = "Project with agent service enabled"

        role_assignments = {
          storage = {
            scope                = module.storage.account.id
            role_definition_name = "Storage Blob Data Contributor"
          }
          cosmosdb = {
            scope                = module.cosmosdb.account.id
            role_definition_name = "Cosmos DB Operator"
          }
          search-index = {
            scope                = module.search.search_service.id
            role_definition_name = "Search Index Data Contributor"
          }
          search-service = {
            scope                = module.search.search_service.id
            role_definition_name = "Search Service Contributor"
          }
        }

        connections = {
          storage = {
            category = "AzureStorageAccount"
            target   = module.storage.account.primary_blob_endpoint
            metadata = {
              ApiType    = "Azure"
              ResourceId = module.storage.account.id
              location   = module.rg.groups.demo.location
            }
          }
          cosmosdb = {
            category = "CosmosDb"
            target   = module.cosmosdb.account.endpoint
            metadata = {
              ApiType    = "Azure"
              ResourceId = module.cosmosdb.account.id
              location   = module.rg.groups.demo.location
            }
          }
          search = {
            category = "CognitiveSearch"
            target   = "https://${module.search.search_service.name}.search.windows.net"
            metadata = {
              ApiType    = "Azure"
              ApiVersion = "2024-05-01-preview"
              ResourceId = module.search.search_service.id
              location   = module.rg.groups.demo.location
            }
          }
        }

        capability_host = {
          storage_connections        = ["storage"]
          thread_storage_connections = ["cosmosdb"]
          vector_store_connections   = ["search"]
        }
      }
    }
  }
}
