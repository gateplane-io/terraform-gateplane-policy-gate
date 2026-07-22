# Copyright (C) 2025 Ioannis Torakis <john.torakis@gmail.com>
# SPDX-License-Identifier: Elastic-2.0
#
# Licensed under the Elastic License 2.0.
# You may obtain a copy of the license at:
# https://www.elastic.co/licensing/elastic-license
#
# Use, modification, and redistribution permitted under the terms of the license,
# except for providing this software as a commercial service or product.

resource "vault_token" "this" {
  policies     = [var.gateplane_policy_gate_policy_name]
  no_parent    = true
  renewable    = true
  period       = "1h"
  wrapping_ttl = "5m"
}

resource "vault_generic_endpoint" "plugin_api_vault_config" {
  depends_on = [module.base]

  path                 = local.plugin_paths["vault"]
  disable_read         = false
  disable_delete       = true
  ignore_absent_fields = true

  data_json = jsonencode({
    "url"           = var.vault_addr_local
    "wrapped_token" = vault_token.this.wrapped_token
  })
}
