# Workflow inputs (how to provide values)

We've simplified the UX: instead of rendering templates with external tools, just copy the provided template and edit it directly.

Steps

1. Copy the template to the generated filename:

```bash
cp .github/workflows/inputs.json.tpl .github/workflows/inputs.json
```

2. Edit `.github/workflows/inputs.json` and fill in your values.

Example snippet from `.github/workflows/inputs.json`:

```json
{
  "vault_addr": "https://vault.example.com:8200",
  "vault_role": "github-actions",
  "vault_namespace": "admin",
  "vault_secret_path": "database/creds/snowflake-role",
  "snowflake_organization_name": "my-org",
  "snowflake_account_name": "my-account",
  "tfc_workspace": "snowflake-dataproduct"
}
```

3. Run the workflow via the GitHub CLI:

```bash
gh workflow run "Vault-backed Snowflake Credentials" --json-inputs .github/workflows/inputs.json
```

Security notes

- Do NOT commit `.github/workflows/inputs.json` if it contains secrets or sensitive values. The repository already ignores this file via `.gitignore`.
- For highly sensitive secrets (API tokens, private keys), prefer repository secrets (Settings → Secrets) or a secret store such as Vault rather than embedding them in the inputs file.

If you want me to add a simple validation step or a small helper script later, I can — but this copy-and-edit approach works with zero dependencies.
