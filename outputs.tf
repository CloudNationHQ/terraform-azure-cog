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
