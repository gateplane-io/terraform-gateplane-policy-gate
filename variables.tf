# Copyright (C) 2025 Ioannis Torakis <john.torakis@gmail.com>
# SPDX-License-Identifier: Elastic-2.0
#
# Licensed under the Elastic License 2.0.
# You may obtain a copy of the license at:
# https://www.elastic.co/licensing/elastic-license
#
# Use, modification, and redistribution permitted under the terms of the license,
# except for providing this software as a commercial service or product.

variable "protected_path_map" {
  description = "A map of Vault/OpenBao paths to lists of capabilities, to be protected by this gate (e.g.: `{\"secret/data/mysecret\":[\"read\"]}`).\nMutually exclusive with `protected_policies`."
  default     = null

}

variable "protected_policies" {
  description = "The Vault/OpenBao policies that will be claimed by this gate.\nMutually exclusive with `protected_path_map`"
  default     = null
  validation {
    // XOR
    condition = (
      (var.protected_path_map == null || var.protected_policies == null) &&
      (var.protected_path_map != null || var.protected_policies != null)
    )
    error_message = "Exactly one of 'protected_path_map' and 'protected_policies' must be set."
  }
}

variable "plugin_name" {
  description = "The name of the plugin to mount (e.g: `gateplane-policy-gate`)."
  default     = "gateplane-policy-gate"
}

variable "policy_prefix" {
  description = "The prefix used for the Policy created by `protected_path_map` variable."
  default     = "gateplane"
}

// Required by AppRole Configuration
variable "approle_mount" {
  description = "The Vault/OpenBao AppRole Auth Method mount that the plugin will authenticate against."
  default     = "gateplane/approle"
}

variable "approle_policy_name" {
  description = "The name of the Vault/OpenBao Policy to be assigned to the plugin (created by [`gateplane-setup`](https://github.com/gateplane-io/terraform-gateplane-setup) plugin)"
  default     = "gateplane-policy-gate-policy"
}

variable "vault_addr_local" {
  description = "The URL used by the Vault/OpenBao plugin (running alongside Vault/OpenBao) to access the API. Can be the one used by the Vault Provider or a local URL."
  default     = "http://127.0.0.1:8200"
}

// Required by Base Plugin
variable "name" {
  description = "Name of the gate, used in the mount path and generated policies."
}

variable "description" {
  description = "Brief explanation of what access is requested through this gate."
  default     = ""
}

# TODO: allow a way to set absolute path, no parameterization
variable "endpoint_prefix" {
  default = "gp"
}

variable "path_prefix" {
  description = "The endpoint where the plugin will be mounted."
  default     = "gateplane"
}

variable "lease_ttl" {
  description = "The duration that the protected token will be active (e.g.: \"`30m`\")."
  default     = "30m"
}

variable "lease_max_ttl" {
  description = "The duration that the protected token will be active (e.g.: \"`1h`\")."
  default     = "1h"
}

variable "plugin_options" {
  description = "Base options provided by the plugin to the `/config` endpoint, available [in plugin documentation](https://github.com/gateplane-io/vault-plugins)."
  default     = {}
}
