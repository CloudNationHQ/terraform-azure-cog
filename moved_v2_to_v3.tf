moved {
  from = azurerm_cognitive_account.cognitive_account
  to   = azurerm_cognitive_account.this
}

moved {
  from = azurerm_cognitive_deployment.deployment
  to   = azurerm_cognitive_deployment.this
}

moved {
  from = azurerm_cognitive_account_rai_blocklist.blocklist
  to   = azurerm_cognitive_account_rai_blocklist.this
}

moved {
  from = azurerm_cognitive_account_rai_policy.policy
  to   = azurerm_cognitive_account_rai_policy.this
}

moved {
  from = azurerm_cognitive_account_project.project
  to   = azurerm_cognitive_account_project.this
}
