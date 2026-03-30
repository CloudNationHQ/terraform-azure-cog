output "account" {
  description = "Contains all the outputs for the cognitive account"
  value       = azurerm_cognitive_account.cognitive_account
}

output "deployments" {
  description = "Contains all the outputs for the cognitive deployments"
  value       = azurerm_cognitive_deployment.deployment
}

output "blocklists" {
  description = "Contains all the outputs for the cognitive blocklists"
  value       = azurerm_cognitive_account_rai_blocklist.blocklist
}

output "policies" {
  description = "Contains all the outputs for the cognitive policies"
  value       = azurerm_cognitive_account_rai_policy.policy
}

output "projects" {
  description = "Contains all the outputs for the cognitive projects"
  value       = azurerm_cognitive_account_project.project
}
