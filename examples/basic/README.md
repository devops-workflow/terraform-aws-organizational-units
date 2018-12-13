# terraform-aws-organizational-units: basic

Configuration in this directory sets up some organizational units

## Usage

Create a terraform.tfvars file with your settings

Then to run this example you need to execute:

```bash
terraform init
terraform plan
terraform apply
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| aws\_profile | AWS profile in local credentials file that has rights to master account | string | - | yes |
| aws\_region | AWS region | string | `us-east-1` | no |
| ou\_list | List of organizational unit to manage. These will be top level under root | string | - | yes |

## Outputs

| Name | Description |
|------|-------------|
| ids | Root and Organizational units IDs |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
