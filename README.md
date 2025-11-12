# Vault/OpenBao setup for [GatePlane Policy-Gate Plugin](https://github.com/gateplane-io/vault-plugins/tree/main/cmd/policy-gate)
![License: ElasticV2](https://img.shields.io/badge/ElasticV2-green?style=flat-square&label=license&cacheSeconds=3600&link=https%3A%2F%2Fwww.elastic.co%2Flicensing%2Felastic-license)
[![Terraform Registry](https://img.shields.io/badge/Terraform-Registry-844FBA?style=flat-square&logo=terraform&logoColor=fff)](https://registry.terraform.io/modules/gateplane-io/policy-gate/gateplane/latest)

This Terraform module mounts the Policy-Gate Plugin under a Vault/OpenBao path.

It additionally creates two policies that can access the mount, in order to both create and approve AccessRequests.

Finally, it optionally enables these policies to be used by the UI (under [`app.gateplane.io`](https://app.gateplane.io) or different domain).


## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.11.0 |
| <a name="requirement_null"></a> [null](#requirement\_null) | >= 3.2.4 |
| <a name="requirement_vault"></a> [vault](#requirement\_vault) | >= 4.7.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_vault"></a> [vault](#provider\_vault) | 4.7.0 |

## Resources

| Name | Type |
|------|------|
| [vault_approle_auth_backend_role.this](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/approle_auth_backend_role) | resource |
| [vault_approle_auth_backend_role_secret_id.this](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/approle_auth_backend_role_secret_id) | resource |
| [vault_generic_endpoint.plugin_api_vault_config](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/generic_endpoint) | resource |
| [vault_generic_endpoint.plugin_config_access](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/generic_endpoint) | resource |
| [vault_policy.target](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/policy) | resource |
| [vault_approle_auth_backend_role_id.this](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/data-sources/approle_auth_backend_role_id) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | Name of the gate, used in the mount path and generated policies. | `any` | n/a | yes |
| <a name="input_approle_mount"></a> [approle\_mount](#input\_approle\_mount) | The Vault/OpenBao AppRole Auth Method mount that the plugin will authenticate against. | `string` | `"gateplane/approle"` | no |
| <a name="input_approle_policy_name"></a> [approle\_policy\_name](#input\_approle\_policy\_name) | The name of the Vault/OpenBao Policy to be assigned to the plugin (created by [`gateplane-setup`](https://github.com/gateplane-io/terraform-gateplane-setup) plugin) | `string` | `"gateplane-policy-gate-policy"` | no |
| <a name="input_description"></a> [description](#input\_description) | Brief explanation of what access is requested through this gate. | `string` | `""` | no |
| <a name="input_endpoint_prefix"></a> [endpoint\_prefix](#input\_endpoint\_prefix) | TODO: allow a way to set absolute path, no parameterization | `string` | `"gp"` | no |
| <a name="input_lease_max_ttl"></a> [lease\_max\_ttl](#input\_lease\_max\_ttl) | The duration that the protected token will be active (e.g.: "`1h`"). | `string` | `"1h"` | no |
| <a name="input_lease_ttl"></a> [lease\_ttl](#input\_lease\_ttl) | The duration that the protected token will be active (e.g.: "`30m`"). | `string` | `"30m"` | no |
| <a name="input_path_prefix"></a> [path\_prefix](#input\_path\_prefix) | The endpoint where the plugin will be mounted. | `string` | `"gateplane"` | no |
| <a name="input_plugin_name"></a> [plugin\_name](#input\_plugin\_name) | The name of the plugin to mount (e.g: `gateplane-policy-gate`). | `string` | `"gateplane-policy-gate"` | no |
| <a name="input_plugin_options"></a> [plugin\_options](#input\_plugin\_options) | Base options provided by the plugin to the `/config` endpoint, available [in plugin documentation](https://github.com/gateplane-io/vault-plugins). | `map` | `{}` | no |
| <a name="input_policy_prefix"></a> [policy\_prefix](#input\_policy\_prefix) | The prefix used for the Policy created by `protected_path_map` variable. | `string` | `"gateplane"` | no |
| <a name="input_protected_path_map"></a> [protected\_path\_map](#input\_protected\_path\_map) | A map of Vault/OpenBao paths to lists of capabilities, to be protected by this gate (e.g.: `{"secret/data/mysecret":["read"]}`).<br/>Mutually exclusive with `protected_policies`. | `any` | `null` | no |
| <a name="input_protected_policies"></a> [protected\_policies](#input\_protected\_policies) | The Vault/OpenBao policies that will be claimed by this gate.<br/>Mutually exclusive with `protected_path_map` | `any` | `null` | no |
| <a name="input_vault_addr_local"></a> [vault\_addr\_local](#input\_vault\_addr\_local) | The URL used by the Vault/OpenBao plugin (running alongside Vault/OpenBao) to access the API. Can be the one used by the Vault Provider or a local URL. | `string` | `"http://127.0.0.1:8200"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_mount_path"></a> [mount\_path](#output\_mount\_path) | The Vault/OpenBao path where the plugin has been mounted. |
| <a name="output_paths"></a> [paths](#output\_paths) | The map of paths supported by this plugin. |
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
