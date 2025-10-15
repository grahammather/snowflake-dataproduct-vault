terraform {
  required_providers {
    snowflake = {
      source = "snowflakedb/snowflake"
    }
    vault = {
      source  = "hashicorp/vault"
    }
  }
}

provider "vault" {
  # Vault provider config comes from environment variables
}

# 
data "vault_generic_secret" "snowflake_tmp_user" {
  path = "database/creds/my-snowflake-role"
}

provider "snowflake" {
  organization_name = var.organization_name
  account_name      = var.account_name
  role              = "ACCOUNTADMIN"
  authenticator     = "SNOWFLAKE_JWT"
  user              = data.vault_generic_secret.snowflake_tmp_user.data["username"]
  private_key       = data.vault_generic_secret.snowflake_tmp_user.data["rsa_private_key"]
}

resource "snowflake_database" "tf_db" {
  name         = "TF_DEMO_DB"
  is_transient = false
}

