data "azurerm_client_config" "current" {}

resource "azurerm_cognitive_account" "this" {
  resource_group_name = coalesce(
    var.account.resource_group_name, var.resource_group_name
  )

  location = coalesce(
    var.account.location, var.location
  )

  name                                         = var.account.name
  kind                                         = var.account.kind
  sku_name                                     = var.account.sku_name
  custom_subdomain_name                        = var.account.custom_subdomain_name
  dynamic_throttling_enabled                   = var.account.dynamic_throttling_enabled
  fqdns                                        = var.account.fqdns
  local_auth_enabled                           = var.account.local_auth_enabled
  metrics_advisor_aad_client_id                = var.account.metrics_advisor_aad_client_id
  metrics_advisor_aad_tenant_id                = var.account.metrics_advisor_aad_tenant_id
  metrics_advisor_super_user_name              = var.account.metrics_advisor_super_user_name
  metrics_advisor_website_name                 = var.account.metrics_advisor_website_name
  outbound_network_access_restricted           = var.account.outbound_network_access_restricted
  public_network_access_enabled                = var.account.public_network_access_enabled
  project_management_enabled                   = var.account.project_management_enabled
  qna_runtime_endpoint                         = var.account.qna_runtime_endpoint
  custom_question_answering_search_service_id  = var.account.custom_question_answering_search_service_id
  custom_question_answering_search_service_key = var.account.custom_question_answering_search_service_key

  tags = coalesce(
    var.account.tags, var.tags
  )

  dynamic "customer_managed_key" {
    for_each = var.account.customer_managed_key != null && !var.account.customer_managed_key.standalone ? { this = var.account.customer_managed_key } : {}

    content {
      key_vault_key_id   = customer_managed_key.value.key_vault_key_id
      identity_client_id = customer_managed_key.value.identity_client_id
    }
  }

  dynamic "identity" {
    for_each = var.account.identity != null ? { this = var.account.identity } : {}
    content {
      type         = identity.value.type
      identity_ids = identity.value.identity_ids
    }
  }

  dynamic "storage" {
    for_each = var.account.storage

    content {
      storage_account_id = storage.value.storage_account_id
      identity_client_id = storage.value.identity_client_id
    }
  }

  dynamic "network_acls" {
    for_each = var.account.network_acls != null ? { this = var.account.network_acls } : {}

    content {
      default_action = network_acls.value.default_action
      ip_rules       = network_acls.value.ip_rules
      bypass         = network_acls.value.bypass

      dynamic "virtual_network_rules" {
        for_each = network_acls.value.virtual_network_rules

        content {
          subnet_id                            = virtual_network_rules.value.subnet_id
          ignore_missing_vnet_service_endpoint = virtual_network_rules.value.ignore_missing_vnet_service_endpoint
        }
      }
    }
  }

  dynamic "network_injection" {
    for_each = var.account.network_injection != null ? { this = var.account.network_injection } : {}

    content {
      scenario  = network_injection.value.scenario
      subnet_id = network_injection.value.subnet_id
    }
  }
}

resource "azurerm_cognitive_deployment" "this" {
  for_each = var.account.deployments

  name = coalesce(
    each.value.name, each.key
  )

  cognitive_account_id       = azurerm_cognitive_account.this.id
  dynamic_throttling_enabled = each.value.dynamic_throttling_enabled
  rai_policy_name            = each.value.rai_policy_name
  version_upgrade_option     = each.value.version_upgrade_option

  model {
    format  = each.value.model.format
    name    = each.value.model.name
    version = each.value.model.version
  }

  sku {
    name     = each.value.sku.name
    tier     = each.value.sku.tier
    size     = each.value.sku.size
    family   = each.value.sku.family
    capacity = each.value.sku.capacity
  }
}

resource "azurerm_cognitive_account_rai_blocklist" "this" {
  for_each = var.account.blocklists

  name = coalesce(
    each.value.name, each.key
  )

  cognitive_account_id = azurerm_cognitive_account.this.id
  description          = each.value.description

  tags = coalesce(
    each.value.tags, var.tags
  )
}

resource "azurerm_cognitive_account_rai_policy" "this" {
  for_each = var.account.policies

  name = coalesce(
    each.value.name, each.key
  )

  cognitive_account_id = azurerm_cognitive_account.this.id
  base_policy_name     = each.value.base_policy_name
  mode                 = each.value.mode

  dynamic "content_filter" {
    for_each = each.value.content_filters

    content {
      name               = content_filter.value.name
      filter_enabled     = content_filter.value.filter_enabled
      block_enabled      = content_filter.value.block_enabled
      severity_threshold = content_filter.value.severity_threshold
      source             = content_filter.value.source
    }
  }

  tags = coalesce(
    each.value.tags, var.tags
  )
}

resource "azurerm_cognitive_account_project" "this" {
  for_each = var.account.projects

  name = coalesce(
    each.value.name, each.key
  )


  location = coalesce(
    each.value.location,
    azurerm_cognitive_account.this.location
  )

  cognitive_account_id = azurerm_cognitive_account.this.id
  description          = each.value.description
  display_name         = each.value.display_name

  identity {
    type         = each.value.identity.type
    identity_ids = each.value.identity.identity_ids
  }

  tags = coalesce(
    each.value.tags, var.tags
  )
}

resource "azurerm_cognitive_account_customer_managed_key" "this" {
  for_each = var.account.customer_managed_key != null && var.account.customer_managed_key.standalone ? { this = var.account.customer_managed_key } : {}

  cognitive_account_id = azurerm_cognitive_account.this.id
  key_vault_key_id     = each.value.key_vault_key_id
  identity_client_id   = each.value.identity_client_id

  depends_on = [azurerm_role_assignment.this]
}

resource "azurerm_role_assignment" "this" {
  for_each = merge(
    {
      for key, assignment in var.account.role_assignments :
      key => merge(assignment, {
        scope        = coalesce(assignment.scope, azurerm_cognitive_account.this.id)
        principal_id = coalesce(assignment.principal_id, data.azurerm_client_config.current.object_id)
      })
    },
    merge([
      for project_key, project in var.account.projects : {
        for key, assignment in project.role_assignments :
        "${project_key}.${key}" => merge(assignment, {
          principal_id = coalesce(assignment.principal_id, azurerm_cognitive_account_project.this[project_key].identity[0].principal_id)
        })
      }
    ]...)
  )

  name                                   = each.value.name
  scope                                  = each.value.scope
  principal_id                           = each.value.principal_id
  role_definition_name                   = each.value.role_definition_name
  role_definition_id                     = each.value.role_definition_id
  description                            = each.value.description
  principal_type                         = each.value.principal_type
  condition                              = each.value.condition
  condition_version                      = each.value.condition_version
  delegated_managed_identity_resource_id = each.value.delegated_managed_identity_resource_id
  skip_service_principal_aad_check       = each.value.skip_service_principal_aad_check
}

resource "azurerm_cognitive_account_connection_entra_id" "this" {
  for_each = {
    for key, connection in var.account.connections :
    key => connection if connection.auth_type == "AAD"
  }

  name = coalesce(
    each.value.name, each.key
  )

  cognitive_account_id = azurerm_cognitive_account.this.id
  category             = each.value.category
  target               = each.value.target
  metadata             = each.value.metadata
}

resource "azurerm_cognitive_account_connection_account_managed_identity" "this" {
  for_each = {
    for key, connection in var.account.connections :
    key => connection if connection.auth_type == "ManagedIdentity"
  }

  name = coalesce(
    each.value.name, each.key
  )

  cognitive_account_id = azurerm_cognitive_account.this.id
  category             = each.value.category
  target               = each.value.target
  metadata             = each.value.metadata
}

resource "azurerm_cognitive_account_connection_api_key" "this" {
  for_each = {
    for key, connection in var.account.connections :
    key => connection if connection.auth_type == "ApiKey"
  }

  name = coalesce(
    each.value.name, each.key
  )

  cognitive_account_id = azurerm_cognitive_account.this.id
  category             = each.value.category
  target               = each.value.target
  metadata             = each.value.metadata
  api_key              = each.value.api_key
}

resource "azurerm_cognitive_account_connection_account_key" "this" {
  for_each = {
    for key, connection in var.account.connections :
    key => connection if connection.auth_type == "AccountKey"
  }

  name = coalesce(
    each.value.name, each.key
  )

  cognitive_account_id = azurerm_cognitive_account.this.id
  category             = each.value.category
  target               = each.value.target
  metadata             = each.value.metadata
  account_key          = each.value.account_key
}

resource "azurerm_cognitive_account_connection_custom_keys" "this" {
  for_each = {
    for key, connection in var.account.connections :
    key => connection if connection.auth_type == "CustomKeys"
  }

  name = coalesce(
    each.value.name, each.key
  )

  cognitive_account_id = azurerm_cognitive_account.this.id
  category             = each.value.category
  target               = each.value.target
  metadata             = each.value.metadata
  custom_keys          = each.value.custom_keys
}

resource "azapi_resource" "capability_host" {
  for_each = var.account.capability_host != null ? { this = var.account.capability_host } : {}

  name = coalesce(
    each.value.name, "default"
  )

  body = {
    properties = {
      capabilityHostKind       = each.value.capability_host_kind
      storageConnections       = each.value.storage_connections
      threadStorageConnections = each.value.thread_storage_connections
      vectorStoreConnections   = each.value.vector_store_connections
    }
  }

  type                      = "Microsoft.CognitiveServices/accounts/capabilityHosts@2025-04-01-preview"
  parent_id                 = azurerm_cognitive_account.this.id
  schema_validation_enabled = false

  retry = {
    error_message_regex = ["RequestConflict", "TransientError", "Etag conflict"]
  }

  depends_on = [
    azurerm_cognitive_account_connection_entra_id.this,
    azurerm_cognitive_account_connection_account_managed_identity.this,
    azurerm_cognitive_account_connection_api_key.this,
    azurerm_cognitive_account_connection_account_key.this,
    azurerm_cognitive_account_connection_custom_keys.this
  ]
}

resource "azapi_resource" "project_connection" {
  for_each = merge([
    for project_key, project in var.account.projects : {
      for connection_key, connection in project.connections :
      "${project_key}.${connection_key}" => merge(connection, {
        project_key = project_key
        name        = coalesce(connection.name, connection_key)
      })
    }
  ]...)

  name = each.value.name

  body = {
    properties = {
      category = each.value.category
      target   = each.value.target
      authType = each.value.auth_type
      metadata = each.value.metadata
    }
  }

  type                      = "Microsoft.CognitiveServices/accounts/projects/connections@2025-04-01-preview"
  parent_id                 = azurerm_cognitive_account_project.this[each.value.project_key].id
  schema_validation_enabled = false

  retry = {
    error_message_regex = ["RequestConflict", "TransientError", "Etag conflict"]
  }
}

resource "azapi_resource" "project_capability_host" {
  for_each = {
    for project_key, project in var.account.projects :
    project_key => project.capability_host if project.capability_host != null
  }

  name = coalesce(
    each.value.name, "default"
  )

  body = {
    properties = {
      capabilityHostKind       = each.value.capability_host_kind
      storageConnections       = each.value.storage_connections
      threadStorageConnections = each.value.thread_storage_connections
      vectorStoreConnections   = each.value.vector_store_connections
    }
  }

  type                      = "Microsoft.CognitiveServices/accounts/projects/capabilityHosts@2025-04-01-preview"
  parent_id                 = azurerm_cognitive_account_project.this[each.key].id
  schema_validation_enabled = false

  retry = {
    error_message_regex = ["RequestConflict", "TransientError", "Etag conflict"]
  }

  depends_on = [
    azapi_resource.capability_host,
    azapi_resource.project_connection,
    azurerm_role_assignment.this
  ]
}
