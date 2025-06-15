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
  value       = local.plugin_paths_base
}

output "policy_names" {
  description = "The names of the policies created and referenced in this module."
  value = {
    "requestor" = vault_policy.user.name,
    "approver"  = vault_policy.gtkpr.name,
    "protected" = [for policy in local.protected_policies : policy]
  }
}

output "policies" {
  description = "The verbatim policies created and referenced in this module."
  value = {
    "requestor" = vault_policy.user.policy,
    "approver"  = vault_policy.gtkpr.policy,
    "protected" = var.protected_policies == null ? vault_policy.target[0].policy : null
  }
}
