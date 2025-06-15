# Copyright (C) 2025 Ioannis Torakis <john.torakis@gmail.com>
# SPDX-License-Identifier: Elastic-2.0
#
# Licensed under the Elastic License 2.0.
# You may obtain a copy of the license at:
# https://www.elastic.co/licensing/elastic-license
#
# Use, modification, and redistribution permitted under the terms of the license,
# except for providing this software as a commercial service or product.

locals {
  ui_policies = <<EOF
// --- Capabilities used by the UI

path "sys/auth" {
  capabilities = ["read", "list"]
}

path "sys/mounts" {
  capabilities = ["read"]
}

path "sys/auth/*" {
  capabilities = ["read"]
}

path "sys/policy/*" {
  capabilities = ["read"]
}

path "sys/capabilities-self" {
  capabilities = ["update"]
}

path "auth/token/lookup-self" {
  capabilities = ["read"]
}

path "identity/entity/id/*" {
  capabilities = ["read"]
}

// Used to automatically sign you in with Vault OIDC
// for Notification server interaction
path "auth/token/create" {
  capabilities = ["update"]
}

path "secret/data/gateplane/*" {
  capabilities = ["read"]
}

path "sys/wrapping/unwrap" {
  capabilities = ["update"]
}

// -- Gatekeeper specific
path "${local.plugin_paths["config"]}" {
  capabilities = ["read"]
}

EOF
}
