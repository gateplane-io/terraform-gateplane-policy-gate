# Copyright (C) 2025 Ioannis Torakis <john.torakis@gmail.com>
# SPDX-License-Identifier: Elastic-2.0
#
# Licensed under the Elastic License 2.0.
# You may obtain a copy of the license at:
# https://www.elastic.co/licensing/elastic-license
#
# Use, modification, and redistribution permitted under the terms of the license,
# except for providing this software as a commercial service or product.

module "base" {
  source = "github.com/gateplane-io/terraform-gateplane-base-gate.git?ref=0.1.1"

  plugin_name = var.plugin_name

  name        = var.name
  description = var.description

  policy_prefix   = var.policy_prefix
  endpoint_prefix = var.endpoint_prefix
  path_prefix     = var.path_prefix

  lease_ttl     = var.lease_ttl
  lease_max_ttl = var.lease_max_ttl

  plugin_options = var.plugin_options
}
