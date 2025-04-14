variable "account" {
  description = "Contains the cognitive services account configuration"
  type = object({
    name                                         = string
    resource_group                               = optional(string, null)
    location                                     = optional(string, null)
    tags                                         = optional(map(string))
    sku_name                                     = optional(string, "S0")
    kind                                         = optional(string, "CognitiveServices")
    custom_subdomain_name                        = optional(string)
    dynamic_throttling_enabled                   = optional(bool, false)
    fqdns                                        = optional(list(string))
    local_auth_enabled                           = optional(bool, false)
    metrics_advisor_aad_client_id                = optional(string)
    metrics_advisor_aad_tenant_id                = optional(string)
    metrics_advisor_super_user_name              = optional(string)
    metrics_advisor_website_name                 = optional(string)
    outbound_network_access_restricted           = optional(bool, false)
    public_network_access_enabled                = optional(bool, false)
    qna_runtime_endpoint                         = optional(string)
    custom_question_answering_search_service_id  = optional(string)
    custom_question_answering_search_service_key = optional(string)

    customer_managed_key = optional(object({
      key_vault_key_id   = string
      identity_client_id = optional(string)
    }))

    identity = optional(object({
      name           = optional(string)
      type           = optional(string, "UserAssigned")
      resource_group = optional(string)
      location       = optional(string)
      identity_ids   = optional(list(string), [])
    }))

    storage = optional(object({
      storage_account_id = optional(string)
      identity_client_id = optional(string)
    }))

    network_acls = optional(object({
      default_action = optional(string)
      ip_rules       = optional(list(string))
      virtual_network_rules = optional(object({
        subnet_id                            = string
        ignore_missing_vnet_service_endpoint = optional(bool, false)
      }))
    }))

    deployments = optional(map(object({
      name = optional(string)
      model = object({
        format  = string
        name    = string
        version = optional(string)
      })
      sku = object({
        name     = string
        tier     = optional(string)
        size     = optional(string)
        family   = optional(string)
        capacity = optional(number)
      })
    })))

    blocklists = optional(map(object({
      name        = optional(string)
      description = optional(string)
    })))
  })

  validation {
    condition     = var.account.location != null || var.location != null
    error_message = "location must be provided either in the account object or as a separate variable."
  }

  validation {
    condition     = var.account.resource_group != null || var.resource_group != null
    error_message = "resource group name must be provided either in the account object or as a separate variable."
  }
}

variable "naming" {
  description = "contains naming convention"
  type        = map(string)
  default     = null
}

variable "location" {
  description = "default azure region to be used."
  type        = string
  default     = null
}

variable "resource_group" {
  description = "default resource group to be used."
  type        = string
  default     = null
}

variable "tags" {
  description = "tags to be added to the resources"
  type        = map(string)
  default     = {}
}
