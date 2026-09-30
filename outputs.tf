output "account" {
  description = "Contains all the outputs for the cognitive account"
  value       = azurerm_cognitive_account.this
}

output "deployments" {
  description = "Contains all the outputs for the cognitive deployments"
  value       = azurerm_cognitive_deployment.this
}

output "blocklists" {
  description = "Contains all the outputs for the cognitive blocklists"
  value       = azurerm_cognitive_account_rai_blocklist.this
}

output "policies" {
  description = "Contains all the outputs for the cognitive policies"
  value       = azurerm_cognitive_account_rai_policy.this
}

output "projects" {
  description = "Contains all the outputs for the cognitive account projects"
  value       = azurerm_cognitive_account_project.this
}

output "customer_managed_key" {
  description = "Contains all the outputs for the standalone customer managed key"
  value       = azurerm_cognitive_account_customer_managed_key.this
}

output "role_assignments" {
  description = "Contains all the outputs for the role assignments"
  value       = azurerm_role_assignment.this
}

output "connections" {
  description = "Contains all the outputs for the account connections"
  value = merge(
    azurerm_cognitive_account_connection_entra_id.this,
    azurerm_cognitive_account_connection_account_managed_identity.this,
    azurerm_cognitive_account_connection_api_key.this,
    azurerm_cognitive_account_connection_account_key.this,
    azurerm_cognitive_account_connection_custom_keys.this
  )
}

output "capability_host" {
  description = "Contains all the outputs for the account capability host"
  value       = azapi_resource.capability_host
}

output "project_connections" {
  description = "Contains all the outputs for the project connections"
  value       = azapi_resource.project_connection
}

output "project_capability_hosts" {
  description = "Contains all the outputs for the project capability hosts"
  value       = azapi_resource.project_capability_host
}
