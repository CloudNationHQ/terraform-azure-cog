# Cognitive Services

This terraform module enables the efficient creation and management of azure cognitive services. By offering customizable options for the name, location, management locks and tags, it brings granular control over your azure environment.

## Features

Flexible deployment of cognitive service accounts with multi-deployment capabilities

Network protection through ACLs and customizable network rules

Support for customer managed keys and configurable blocklists

Utilization of terratest for robust validation.

<!-- BEGIN_TF_DOCS -->
## Requirements

The following requirements are needed by this module:

- <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) (~> 1.0)

- <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) (~> 4.0)

## Providers

The following providers are used by this module:

- <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) (~> 4.0)

## Resources

The following resources are used by this module:

- [azurerm_cognitive_account.cognitive_account](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cognitive_account) (resource)
- [azurerm_cognitive_account_rai_blocklist.blocklist](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cognitive_account_rai_blocklist) (resource)
- [azurerm_cognitive_account_rai_policy.policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cognitive_account_rai_policy) (resource)
- [azurerm_cognitive_deployment.deployment](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cognitive_deployment) (resource)

## Required Inputs

The following input variables are required:

### <a name="input_account"></a> [account](#input\_account)

Description: Contains the cognitive services account configuration

Type:

```hcl
object({
    name                                         = string
    resource_group_name                          = optional(string)
    location                                     = optional(string)
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
    project_management_enabled                   = optional(bool, false)
    qna_runtime_endpoint                         = optional(string)
    custom_question_answering_search_service_id  = optional(string)
    custom_question_answering_search_service_key = optional(string)
    customer_managed_key = optional(object({
      key_vault_key_id   = string
      identity_client_id = optional(string)
    }))
    identity = optional(object({
      type         = optional(string, "UserAssigned")
      identity_ids = optional(list(string), [])
    }))
    storage = optional(object({
      storage_account_id = optional(string)
      identity_client_id = optional(string)
    }))
    network_acls = optional(object({
      default_action = optional(string)
      ip_rules       = optional(list(string))
      bypass         = optional(string)
      virtual_network_rules = optional(object({
        subnet_id                            = string
        ignore_missing_vnet_service_endpoint = optional(bool, false)
      }))
    }))
    network_injection = optional(object({
      scenario  = string
      subnet_id = string
    }))
    deployments = optional(map(object({
      name                       = optional(string)
      dynamic_throttling_enabled = optional(bool)
      rai_policy_name            = optional(string)
      version_upgrade_option     = optional(string)
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
    policies = optional(map(object({
      name             = optional(string)
      base_policy_name = string
      mode             = optional(string)
      tags             = optional(map(string))
      content_filters = map(object({
        name               = string
        filter_enabled     = bool
        block_enabled      = bool
        severity_threshold = string
        source             = string
      }))
    })))
  })
```

## Optional Inputs

The following input variables are optional (have default values):

### <a name="input_location"></a> [location](#input\_location)

Description: default azure region to be used.

Type: `string`

Default: `null`

### <a name="input_naming"></a> [naming](#input\_naming)

Description: contains naming convention

Type: `map(string)`

Default: `null`

### <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name)

Description: default resource group to be used.

Type: `string`

Default: `null`

### <a name="input_tags"></a> [tags](#input\_tags)

Description: tags to be added to the resources

Type: `map(string)`

Default: `{}`

## Outputs

The following outputs are exported:

### <a name="output_account"></a> [account](#output\_account)

Description: Contains all the outputs for the cognitive account

### <a name="output_blocklists"></a> [blocklists](#output\_blocklists)

Description: Contains all the outputs for the cognitive blocklists

### <a name="output_deployments"></a> [deployments](#output\_deployments)

Description: Contains all the outputs for the cognitive deployments

### <a name="output_policies"></a> [policies](#output\_policies)

Description: Contains all the outputs for the cognitive policies
<!-- END_TF_DOCS -->

## Goals

For more information, please see our [goals and non-goals](./GOALS.md).

## Testing

For more information, please see our testing [guidelines](./TESTING.md)

## Notes

Using a dedicated module, we've developed a naming convention for resources that's based on specific regular expressions for each type, ensuring correct abbreviations and offering flexibility with multiple prefixes and suffixes.

Full examples detailing all usages, along with integrations with dependency modules, are located in the examples directory.

To update the module's documentation run `make doc`

## Contributors

We welcome contributions from the community! Whether it's reporting a bug, suggesting a new feature, or submitting a pull request, your input is highly valued.

For more information, please see our contribution [guidelines](./CONTRIBUTING.md). <br><br>

<a href="https://github.com/cloudnationhq/terraform-azure-cog/graphs/contributors">
  <img src="https://contrib.rocks/image?repo=cloudnationhq/terraform-azure-cog" />
</a>

## License

MIT Licensed. See [LICENSE](./LICENSE) for full details.

## References

- [Documentation](https://azure.microsoft.com/en-us/products/ai-services)
- [Rest Api](https://learn.microsoft.com/en-us/rest/api/cognitiveservices/)
