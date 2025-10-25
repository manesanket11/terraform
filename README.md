# EC2 Instance Terraform Configuration

This Terraform configuration provisions a single EC2 instance and exposes common parameters so you can tailor the instance to your environment.

## Prerequisites
- Terraform >= 1.5.0
- AWS credentials configured via the AWS CLI or environment variables

## Usage
Initialise and review the plan before applying:

```bash
terraform init
terraform plan -out=tfplan
terraform apply tfplan
```

Override defaults by supplying a `terraform.tfvars` file or CLI flags. Example variable file:

```hcl
aws_region    = "us-east-1"
ami_id        = "ami-0c02fb55956c7d316"
instance_type = "t3.micro"
instance_name = "web-app"
common_tags = {
  environment = "dev"
  owner       = "platform"
}
```

## Inputs

| Name | Description | Type | Default |
| --- | --- | --- | --- |
| `aws_region` | AWS region where resources are created. | string | `"us-east-1"` |
| `ami_id` | AMI ID used to launch the EC2 instance. | string | `"ami-039a49e70ea773ffc"` |
| `instance_type` | EC2 instance type. | string | `"t2.micro"` |
| `instance_name` | Value assigned to the Name tag. | string | `"HelloWorld"` |
| `common_tags` | Additional tags to apply to the instance. | map(string) | `{}` |

## Outputs

| Name | Description |
| --- | --- |
| `instance_id` | Identifier of the EC2 instance. |
| `public_ip` | Public IP assigned to the EC2 instance. |

## Next Steps
- Run `terraform destroy` when the instance is no longer required to avoid unnecessary spend.
