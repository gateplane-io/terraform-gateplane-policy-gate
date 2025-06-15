# Copyright (C) 2025 Ioannis Torakis <john.torakis@gmail.com>
# SPDX-License-Identifier: Elastic-2.0
#
# Licensed under the Elastic License 2.0.
# You may obtain a copy of the license at:
# https://www.elastic.co/licensing/elastic-license
#
# Use, modification, and redistribution permitted under the terms of the license,
# except for providing this software as a commercial service or product.

resource "vault_auth_backend" "this" {
  type        = var.plugin_name
  path        = local.plugin_paths_mount
  description = var.description

  tune {
    default_lease_ttl = var.token_lease_ttl
    max_lease_ttl     = var.token_lease_ttl

    audit_non_hmac_request_keys  = ["reason", "policies", "request_id", ]
    audit_non_hmac_response_keys = ["reason", "policies", "request_id", ]
  }
}

resource "vault_generic_endpoint" "plugin_config" {
  depends_on = [vault_auth_backend.this]

  path                 = "auth/${vault_auth_backend.this.path}/config"
  disable_read         = true
  disable_delete       = true
  ignore_absent_fields = true

  data_json = jsonencode(
    merge(var.plugin_options,
      // Comma-separated list
      {
        "policies" = join(",", local.protected_policies)
      }
    )
  )

  lifecycle {
    replace_triggered_by = [null_resource.reconfigure]
  }
}

resource "null_resource" "reconfigure" {
  triggers = {
    always_recreate = timestamp()
  }
}
