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

  plugin_paths_name  = "${var.endpoint_prefix != "" ? "${var.endpoint_prefix}-" : ""}${var.name}"
  plugin_paths_mount = "${var.path_prefix != "" ? "${var.path_prefix}/" : ""}${local.plugin_paths_name}"
  plugin_paths_base  = "auth/${local.plugin_paths_mount}"

  plugin_paths = {
    request = "${local.plugin_paths_base}/request",
    approve = "${local.plugin_paths_base}/approve",
    claim   = "${local.plugin_paths_base}/claim",
    config  = "${local.plugin_paths_base}/config",
  }

  protected_policies = var.protected_policies == null ? [vault_policy.target[0].name] : var.protected_policies

  policy_prefix = "${var.policy_prefix != "" ? "${var.policy_prefix}-" : ""}${var.name}"
}
