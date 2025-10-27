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
  }
}

provider "snowflake" {
  organization_name = var.organization_name
  account_name      = var.account_name
  role              = "ACCOUNTADMIN"
  authenticator     = "SNOWFLAKE_JWT"
}

resource "snowflake_database" "tf_db" {
  name         = "TF_DEMO_DB"
  is_transient = false
}

