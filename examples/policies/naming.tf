locals {
  naming = {
    # lookup outputs to have consistent naming
    for type in local.naming_types : type => lookup(module.naming, type, {}).name
  }

  naming_types = ["cognitive_deployment"]
}
