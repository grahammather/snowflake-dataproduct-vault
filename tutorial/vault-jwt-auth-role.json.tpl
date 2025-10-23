{
  "policies": ["tfc-policy"],
  "bound_audiences": ["vault.workload.identity"],
  "bound_claims_type": "glob",
  "bound_claims": {
    "sub":
"organization:<YOUR ORG NAME>:project:<YOUR PROJECT NAME>:workspace:snowflake-dataproduct-vault:run_phase:*"
  },
  "user_claim": "terraform_full_workspace",
  "role_type": "jwt",
  "token_ttl": "20m"
}
