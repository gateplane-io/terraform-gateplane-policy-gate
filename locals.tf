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

  plugin_paths = merge(module.base.paths, {
    "access" : "${module.base.mount_path}/config/access",
    "vault" : "${module.base.mount_path}/config/api/vault",
  })

  protected_policies = var.protected_policies == null ? [vault_policy.target[0].name] : var.protected_policies

  policy_prefix = "${var.policy_prefix != "" ? "${var.policy_prefix}-" : ""}${var.name}"
}
