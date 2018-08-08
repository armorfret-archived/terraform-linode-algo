terraform-linode-algo
=========

[![MIT Licensed](https://img.shields.io/badge/license-MIT-green.svg)](https://tldrlegal.com/license/mit-license)

Terraform module that creates a [Linode](https://linode.com) with [Algo](https://github.com/trailofbits/algo) running on it.

## Usage

```
module "vpn" {
  source  = "github.com/akerl/terraform-linode-algo"
  ssh_key = "PUT_YOUR_PUBKEY_HERE"

  users = [
    "alfa",
    "beta",
  ]
}
```

## License

terraform-linode-algo is released under the MIT License. See the bundled LICENSE file for details.
