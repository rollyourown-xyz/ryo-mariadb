# SPDX-FileCopyrightText: 2022 Wilfred Nicoll <xyzroller@rollyourown.xyz>
# SPDX-License-Identifier: GPL-3.0-or-later

terraform {
  required_version = ">= 0.15"
  required_providers {
    mysql = {
      source  = "terraform-providers/mysql"
      version = ">= 1.5"
    }
  }
}

###
# Provision mysql database with user on list of hosts
###

resource "mysql_database" "db" {
  
  name                  = var.mysql_db_name
  default_character_set = var.mysql_db_default_charset
  default_collation     = var.mysql_db_default_collation

}

resource "mysql_user" "user" {

  depends_on = [ mysql_database.db ]

  for_each = toset(var.mysql_db_user_hosts)

  user               = var.mysql_db_user
  host               = each.key
  plaintext_password = var.mysql_db_user_password
}

resource "mysql_grant" "grant" {
  
  depends_on = [ mysql_database.db, mysql_user.user ]

  for_each = toset(var.mysql_db_user_hosts)

  user       = var.mysql_db_user
  host       = each.key
  database   = var.mysql_db_name
  table      = var.mysql_db_table
  privileges = var.mysql_db_privileges
}
