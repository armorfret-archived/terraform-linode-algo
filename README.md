terraform-provider-awscreds
=========

[![Build Status](https://img.shields.io/circleci/project/akerl/terraform-provider-awscreds/master.svg)](https://circleci.com/gh/akerl/terraform-provider-awscreds)
[![GitHub release](https://img.shields.io/github/release/akerl/terraform-provider-awscreds.svg)](https://github.com/akerl/terraform-provider-awscreds/releases)
[![MIT Licensed](https://img.shields.io/badge/license-MIT-green.svg)](https://tldrlegal.com/license/mit-license)

Terraform Provider to generate IAM access keys without storing the secret in the statefile

## Usage

You can use the provider in your terraform files to create IAM users:

```
provider "aws" {
    region = "us-east-1"
}

provider "awscreds" {
    region = "us-east-1"
}

resource "aws_iam_user" "my_cool_user" {
    name = "my_cool_user"

resource "awscreds_iam_access_key" {
    user = "${aws_iam_user.my_cool_user.name}"
    file = "./secret_creds"
}
```

The "awscreds" provider takes all the same options as the "aws" provider, and has the same behavior (it checks the same default environment variables and configs for credentials).

The "awscreds_iam_access_key" resource accepts the same options as the "aws_iam_access_key" resource (currently just "user"), and additionally requires the "file" option, which should be the path in which to store the access key and secret key. They are stored newline-delimited in the file.

## Installation

Go to https://github.com/akerl/terraform-provider-awscreds/releases and download the latest release for your platform, and plop it into your `~/.terraform.d/plugins` as `terraform-provider-awscreds`

### Development

To build from source, clone this repo and run `make` inside it.

## License

terraform-provider-awscreds is released under the MIT License. See the bundled LICENSE file for details.
