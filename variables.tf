# ==========

variable "organization_name" {
  description = "Snowflake Organization (org) identifier. Used to scope resources to your Snowflake org."
  type        = string
}

variable "account_name" {
  description = "Snowflake Account name. Typically the account locator used in connection strings."
  type        = string
}