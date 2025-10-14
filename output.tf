# Copyright (C) 2025 Ioannis Torakis <john.torakis@gmail.com>
# SPDX-License-Identifier: Elastic-2.0
#
# Licensed under the Elastic License 2.0.
# You may obtain a copy of the license at:
# https://www.elastic.co/licensing/elastic-license
#
# Use, modification, and redistribution permitted under the terms of the license,
# except for providing this software as a commercial service or product.

output "mount_path" {
  description = "The Vault/OpenBao path where the plugin has been mounted."
  value       = module.base.mount_path
}

output "policy_names" {
  description = "The names of the policies created and referenced in this module."
  value = {
    "requestor" = module.base.policy_names["requestor"],
    "approver"  = module.base.policy_names["approver"],
    "protected" = [for policy in local.protected_policies : policy]
  }
}

output "policies" {
  description = "The verbatim policies created and referenced in this module."
  value = {
    "requestor" = module.base.policies["requestor"],
    "approver"  = module.base.policies["approver"],
    "protected" = var.protected_policies == null ? vault_policy.target[0].policy : null
  }
}

output "paths" {
  description = "The map of paths supported by this plugin."
  value       = local.plugin_paths
}
