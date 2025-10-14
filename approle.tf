# Copyright (C) 2025 Ioannis Torakis <john.torakis@gmail.com>
# SPDX-License-Identifier: Elastic-2.0
#
# Licensed under the Elastic License 2.0.
# You may obtain a copy of the license at:
# https://www.elastic.co/licensing/elastic-license
#
# Use, modification, and redistribution permitted under the terms of the license,
# except for providing this software as a commercial service or product.

# Enable the AppRole auth method at path "approle" (idempotent)
resource "vault_auth_backend" "approle" {
  type        = "approle"
  path        = var.approle_mount
  description = "GatePlane AppRole auth method"
  tune {
    default_lease_ttl = "1h"
    max_lease_ttl     = "1h"
  }
}

resource "vault_policy" "plugin_policy" {
  name   = "${local.policy_prefix}-role-policy"
  policy = <<EOF
// Allow the GatePlane PolicyGate plugin
// to alter Entity Policies
path "identity/entity/id/*" {
  capabilities = ["read", "update"]
}

// Allow authentication check
path "auth/token/lookup-self" {
  capabilities = ["read"]
}
EOF
}

# Create the AppRole and attach the policy
resource "vault_approle_auth_backend_role" "this" {
  backend   = vault_auth_backend.approle.path
  role_name = "${local.policy_prefix}-role"

  token_policies = [
    vault_policy.plugin_policy.name,
  ]
}

data "vault_approle_auth_backend_role_id" "this" {
  backend   = vault_auth_backend.approle.path
  role_name = vault_approle_auth_backend_role.this.role_name
}

resource "vault_approle_auth_backend_role_secret_id" "this" {
  backend   = vault_auth_backend.approle.path
  role_name = vault_approle_auth_backend_role.this.role_name
  # TODO: add cidr_list, metadata, or num_uses
}

resource "vault_generic_endpoint" "plugin_api_vault_config" {
  depends_on = [module.base]

  path                 = local.plugin_paths["vault"]
  disable_read         = true
  disable_delete       = true
  ignore_absent_fields = true

  data_json = jsonencode({
    "url"           = "http://127.0.0.1:8200"
    "role_id"       = data.vault_approle_auth_backend_role_id.this.role_id
    "role_secret"   = vault_approle_auth_backend_role_secret_id.this.secret_id
    "approle_mount" = vault_auth_backend.approle.path
  })

  lifecycle {
    replace_triggered_by = [null_resource.reconfigure]
  }
}
