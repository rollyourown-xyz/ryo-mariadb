<!--
SPDX-FileCopyrightText: 2022 Wilfred Nicoll <xyzroller@rollyourown.xyz>
SPDX-License-Identifier: CC-BY-SA-4.0
-->

# Deploy a mariadb database and user

This module provisions a mariadb database and user. Various properties of the database and user are specified by input variables:

* mysql_db_name (string): The name of the mysql database to deploy

* mysql_db_default_charset (string): (Optional) The default character set to use for the mysql database. If default is to be used, do not specify.

* mysql_db_default_collation (string): (Optional) The default collation to use for the mysql database. If default is to be used, do not specify.

* mysql_db_user (string): The mysql user to grant privileges on the database.

* mysql_db_user_hosts (list of strings): The source hosts for the mysql user. If localhost is to be used, make sure it is specified.

* mysql_db_user_password (string): The password for the user on the database.

* mysql_db_table (string): (Optional) The table on which to grant the user privileges. The default is "*".

* mysql_db_privileges (list of strings): (Optional) The list of privileges to grant to the user on the database. The default is [ "ALL" ].
