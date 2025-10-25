# Repository Guidelines

## Project Structure & Module Organization
- `main.tf` holds the AWS provider configuration and the single EC2 instance resource; keep additional Terraform files in the repo root and name them by domain (e.g., `network.tf`, `iam.tf`).
- `README.md` summarises module intent; expand it with usage examples whenever module inputs or outputs change.
- Store reusable modules in a `modules/` directory and environment-specific stacks in `envs/<environment>/`; avoid unchecked Terraform files elsewhere.

## Build, Test, and Development Commands
- `terraform init` downloads the AWS provider and prepares the working directory; run after cloning or modifying backend settings.
- `terraform fmt` normalises HCL formatting; use before every commit.
- `terraform validate` performs static validation against the Terraform language spec.
- `terraform plan -out=tfplan` previews infrastructure changes and writes an executable plan file.
- `terraform apply tfplan` applies the reviewed plan; skip experimental flags unless justified in the pull request.
- `terraform destroy` tears down all managed resources when decommissioning test stacks.

## Coding Style & Naming Conventions
- Indent Terraform blocks by two spaces and align `=` for readability; rely on `terraform fmt` to enforce spacing.
- Name resources with clear roles, e.g., `aws_instance.web_app` rather than abbreviations.
- Declare provider and required version constraints explicitly to prevent drift.
- Store reusable inputs in `variables.tf` with descriptive variable names and sensible defaults; expose outputs through `outputs.tf`.

## Testing Guidelines
- Treat `terraform validate` as the minimum gate; builds fail if it reports errors.
- Require `terraform fmt -check` in CI to ensure committed files are formatted.
- Capture and attach the latest `terraform plan` output (redacted for secrets) to every pull request so reviewers can confirm the delta.
- For breaking infrastructure changes, provision a temporary environment and document the verification steps or queries executed.

## Commit & Pull Request Guidelines
- Write commit messages in present-tense imperative (e.g., `Add EC2 instance tags`); group related Terraform updates in a single commit where possible.
- Reference issue IDs with `Fixes #123` in the commit or PR description when applicable.
- Pull requests must include: purpose summary, key change bullets, validation evidence (`terraform validate` and `terraform plan`), and any follow-up tasks.
- Request review from infrastructure owners before applying; include screenshots of AWS console checks when UI changes are relevant.

## Security & Configuration Tips
- Never hard-code AWS credentials or secrets; rely on environment variables or shared credential files configured via `aws configure`.
- Use least-privilege IAM roles for Terraform execution and prefer remote state backends with state locking when collaborating.
- Scrub any sensitive identifiers from shared logs and plans before posting in issues or chat.
