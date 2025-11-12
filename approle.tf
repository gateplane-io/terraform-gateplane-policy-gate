# Copyright (C) 2025 Ioannis Torakis <john.torakis@gmail.com>
# SPDX-License-Identifier: Elastic-2.0
#
# Licensed under the Elastic License 2.0.
# You may obtain a copy of the license at:
# https://www.elastic.co/licensing/elastic-license
#
# Use, modification, and redistribution permitted under the terms of the license,
# except for providing this software as a commercial service or product.

# Create the AppRole and attach the policy
resource "vault_approle_auth_backend_role" "this" {
  backend   = var.approle_mount
  role_name = "${var.approle_policy_name}-${var.name}-role"

  token_policies = [
    var.approle_policy_name
  ]
}

data "vault_approle_auth_backend_role_id" "this" {
  backend   = var.approle_mount
  role_name = vault_approle_auth_backend_role.this.role_name
}

resource "vault_approle_auth_backend_role_secret_id" "this" {
  backend   = var.approle_mount
  role_name = vault_approle_auth_backend_role.this.role_name
  # TODO: add cidr_list, metadata, or num_uses
}

resource "vault_generic_endpoint" "plugin_api_vault_config" {
  depends_on = [module.base]

  path                 = local.plugin_paths["vault"]
  disable_read         = false
  disable_delete       = true
  ignore_absent_fields = true

  data_json = jsonencode({
    "url"           = var.vault_addr_local
    "role_id"       = data.vault_approle_auth_backend_role_id.this.role_id
    "role_secret"   = vault_approle_auth_backend_role_secret_id.this.secret_id
    "approle_mount" = var.approle_mount
  })
}
