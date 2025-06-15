# Vault/OpenBao setup for [GatePlane Policy-Gate Plugin](https://github.com/gateplane-io/vault-plugins/tree/main/cmd/policy-gate)
![License: ElasticV2](https://img.shields.io/badge/ElasticV2-green?style=flat-square&label=license&cacheSeconds=3600&link=https%3A%2F%2Fwww.elastic.co%2Flicensing%2Felastic-license)

This Terraform module mounts the Policy-Gate Plugin under a Vault/OpenBao path.

It additionally creates two policies that can access the mount, in order to both create and approve AccessRequests.

Finally, it optionally enables these policies to be used by the UI (under [`app.gateplane.io`](https://app.gateplane.io) or different domain).


## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.11.0 |
| <a name="requirement_null"></a> [null](#requirement\_null) | >= 3.2.4 |
| <a name="requirement_vault"></a> [vault](#requirement\_vault) | >= 5.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_null"></a> [null](#provider\_null) | 3.2.4 |
| <a name="provider_vault"></a> [vault](#provider\_vault) | 5.0.0 |

## Resources

| Name | Type |
|------|------|
| [null_resource.reconfigure](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [vault_auth_backend.this](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/auth_backend) | resource |
| [vault_generic_endpoint.plugin_config](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/generic_endpoint) | resource |
| [vault_policy.gtkpr](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/policy) | resource |
| [vault_policy.target](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/policy) | resource |
| [vault_policy.user](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/policy) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | Name of the gate, used in the mount path and generated policies | `any` | n/a | yes |
| <a name="input_description"></a> [description](#input\_description) | Brief explanation of what access is claimed by this gate | `string` | `""` | no |
| <a name="input_enable_ui"></a> [enable\_ui](#input\_enable\_ui) | Add capabilities for GatePlane UI to the created policies. | `bool` | `true` | no |
| <a name="input_endpoint_prefix"></a> [endpoint\_prefix](#input\_endpoint\_prefix) | n/a | `string` | `"gp"` | no |
| <a name="input_path_prefix"></a> [path\_prefix](#input\_path\_prefix) | Where under `auth/` will the endpoint be mounted | `string` | `"gateplane"` | no |
| <a name="input_plugin_name"></a> [plugin\_name](#input\_plugin\_name) | n/a | `string` | `"gateplane-policy-gate"` | no |
| <a name="input_plugin_options"></a> [plugin\_options](#input\_plugin\_options) | Options provided by the plugin, available [in plugin documentation](https://github.com/gateplane-io/vault-plugins). | `map` | `{}` | no |
| <a name="input_policy_prefix"></a> [policy\_prefix](#input\_policy\_prefix) | n/a | `string` | `"gateplane"` | no |
| <a name="input_protected_path_map"></a> [protected\_path\_map](#input\_protected\_path\_map) | A map of Vault/OpenBao paths to lists of capabilities, to be protected by this gate (e.g.: `{"secret/data/mysecret":["read"]}`).<br/>Mutually exclusive with `protected_policies`. | `any` | `null` | no |
| <a name="input_protected_policies"></a> [protected\_policies](#input\_protected\_policies) | The Vault/OpenBao policies that will be claimed by this gate.<br/>Mutually exclusive with `protected_path_map` | `any` | `null` | no |
| <a name="input_token_lease_ttl"></a> [token\_lease\_ttl](#input\_token\_lease\_ttl) | The duration that the protected token will be active (e.g.: `1h`). | `string` | `"30m"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_mount_path"></a> [mount\_path](#output\_mount\_path) | The Vault/OpenBao path where the plugin has been mounted. |
| <a name="output_policies"></a> [policies](#output\_policies) | The verbatim policies created and referenced in this module. |
| <a name="output_policy_names"></a> [policy\_names](#output\_policy\_names) | The names of the policies created and referenced in this module. |


## License

This project is licensed under the [Elastic License v2](https://www.elastic.co/licensing/elastic-license).

This means:

- ✅ You can use, fork, and modify it for **yourself** or **within your company**.
- ✅ You can submit pull requests and redistribute modified versions (with the license attached).
- ❌ You may **not** sell it, offer it as a paid product, or use it in a hosted service (e.g., SaaS).
- ❌ You may **not** re-license it under a different license.

In short: You can use and extend the code freely, privately or inside your business - just don’t build a business around it without our permission.
[This FAQ by Elastic](https://www.elastic.co/licensing/elastic-license/faq) greatly summarizes things.

See the [`./LICENSES/Elastic-2.0.txt`](./LICENSES/Elastic-2.0.txt) file for full details.
