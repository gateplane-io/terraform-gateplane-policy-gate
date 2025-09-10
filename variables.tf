# Copyright (C) 2025 Ioannis Torakis <john.torakis@gmail.com>
# SPDX-License-Identifier: Elastic-2.0
#
# Licensed under the Elastic License 2.0.
# You may obtain a copy of the license at:
# https://www.elastic.co/licensing/elastic-license
#
# Use, modification, and redistribution permitted under the terms of the license,
# except for providing this software as a commercial service or product.

variable "name" {
  description = "Name of the gate, used in the mount path and generated policies"
}

variable "description" {
  description = "Brief explanation of what access is claimed by this gate"
  default     = ""
}

variable "policy_prefix" {
  default = "gateplane"
}

variable "endpoint_prefix" {
  default = "gp"
}

variable "path_prefix" {
  description = "Where under `auth/` will the endpoint be mounted"
  default     = "gateplane"
}

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

variable "lease_ttl" {
  description = "The duration that the protected token will be active (e.g.: `1h`)."
  default     = "30m"
}

variable "plugin_options" {
  description = "Options provided by the plugin, available [in plugin documentation](https://github.com/gateplane-io/vault-plugins)."
  default     = {}
}

variable "plugin_name" {
  default = "gateplane-policy-gate"
}

variable "enable_ui" {
  description = "Add capabilities for GatePlane UI to the created policies."
  default     = true
}
