resource "azurerm_cognitive_account" "cognitive_account" {

  resource_group_name = coalesce(
    lookup(
      var.account, "resource_group_name", null
    ), var.resource_group_name
  )

  location = coalesce(
    lookup(var.account, "location", null
    ), var.location
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
    for_each = try(var.account.customer_managed_key, null) != null ? [var.account.customer_managed_key] : []

    content {
      key_vault_key_id   = customer_managed_key.value.key_vault_key_id
      identity_client_id = customer_managed_key.value.identity_client_id
    }
  }

  dynamic "identity" {
    for_each = try(var.account.identity, null) != null ? { default = var.account.identity } : {}
    content {
      type         = identity.value.type
      identity_ids = identity.value.identity_ids
    }
  }

  dynamic "storage" {
    for_each = try(var.account.storage, null) != null ? { default = var.account.storage } : {}

    content {
      storage_account_id = storage.value.storage_account_id
      identity_client_id = storage.value.identity_client_id
    }
  }

  dynamic "network_acls" {
    for_each = try(var.account.network_acls, null) != null ? { default = var.account.network_acls } : {}

    content {
      default_action = network_acls.value.default_action
      ip_rules       = network_acls.value.ip_rules
      bypass         = network_acls.value.bypass

      dynamic "virtual_network_rules" {
        for_each = try(network_acls.value.virtual_network_rules, null) != null ? { default = network_acls.value.virtual_network_rules } : {}

        content {
          subnet_id                            = virtual_network_rules.value.subnet_id
          ignore_missing_vnet_service_endpoint = virtual_network_rules.value.ignore_missing_vnet_service_endpoint
        }
      }
    }
  }

  dynamic "network_injection" {
    for_each = try(var.account.network_injection, null) != null ? { default = var.account.network_injection } : {}

    content {
      scenario  = network_injection.value.scenario
      subnet_id = network_injection.value.subnet_id
    }
  }
}

resource "azurerm_cognitive_deployment" "deployment" {
  for_each = coalesce(
    var.account.deployments != null ? var.account.deployments : {},
    {}
  )

  name = coalesce(
    each.value.name,
    join("-", [var.naming.cognitive_deployment, each.key])
  )

  cognitive_account_id       = azurerm_cognitive_account.cognitive_account.id
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

# blocklist
resource "azurerm_cognitive_account_rai_blocklist" "blocklist" {
  for_each = coalesce(
    var.account.blocklists != null ? var.account.blocklists : {},
    {}
  )

  name = coalesce(
    each.value.name,
  "blocklist-${each.key}")

  cognitive_account_id = azurerm_cognitive_account.cognitive_account.id
  description          = each.value.description
}

resource "azurerm_cognitive_account_rai_policy" "policy" {
  for_each = coalesce(
    var.account.policies != null ? var.account.policies : {},
    {}
  )

  name = coalesce(
    each.value.name,
    "policy-${each.key}"
  )

  cognitive_account_id = azurerm_cognitive_account.cognitive_account.id
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
