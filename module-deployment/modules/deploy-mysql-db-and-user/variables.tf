# SPDX-FileCopyrightText: 2022 Wilfred Nicoll <xyzroller@rollyourown.xyz>
# SPDX-License-Identifier: GPL-3.0-or-later

# Input variable definitions

variable "mysql_db_name" {
  description = "The name of the mysql database to deploy."
  type        = string
}

variable "mysql_db_default_charset" {
  description = "Default character set to use for the mysql database. If default is to be used, do not specify."
  type        = string
  default     = null
}

variable "mysql_db_default_collation" {
  description = "Default collation to use for the mysql database. If default is to be used, do not specify."
  type        = string
  default     = null
}

variable "mysql_db_user" {
  description = "The mysql user to grant privileges on the database."
  type        = string
}

variable "mysql_db_user_hosts" {
  description = "The source hosts for the mysql user. If localhost is to be used, make sure it is specified."
  type        = list(string)
  default     = null
}

variable "mysql_db_user_password" {
  description = "The password for the user."
  type        = string
  sensitive   = true
}

variable "mysql_db_table" {
  description = "Which table on which to grant the user privileges."
  type        = string
  default     = "*"
}

variable "mysql_db_privileges" {
  description = "The list of privileges to grant to the user."
  type        = list(string)
  default     = [ "ALL" ]
}
