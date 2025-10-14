# Copyright (C) 2025 Ioannis Torakis <john.torakis@gmail.com>
# SPDX-License-Identifier: Elastic-2.0
#
# Licensed under the Elastic License 2.0.
# You may obtain a copy of the license at:
# https://www.elastic.co/licensing/elastic-license
#
# Use, modification, and redistribution permitted under the terms of the license,
# except for providing this software as a commercial service or product.

// Target Policy for accessing
// all the provided "protected paths"
resource "vault_policy" "target" {
  count = var.protected_policies == null ? 1 : 0

  name = "${local.policy_prefix}-protected"
  policy = <<EOF

${join("\n", flatten(
  [for path, caps in var.protected_path_map : <<POLICY
path "${path}" {
  capabilities = ${jsonencode(caps)}
}
POLICY
])
)}
EOF

}
