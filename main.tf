terraform {
  cloud {
    organization = "gmather-org"
    workspaces {
      name = "snowflake-dataproduct-vault"
    }
  }
  required_providers {
    snowflake = {
      source = "snowflakedb/snowflake"
    }
    vault = {
      source  = "hashicorp/vault"
      version = "5.3.0"
    }
  }
}

provider "vault" {
  # Configuration options
}

data "vault_generic_secret" "snowflake_tmp_user" {
  path = "database/creds/snowflake-role"
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
