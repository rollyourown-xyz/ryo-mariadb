#!/bin/sh
# SPDX-FileCopyrightText: 2022 Wilfred Nicoll <xyzroller@rollyourown.xyz>
# SPDX-License-Identifier: GPL-3.0-or-later

# If the file "BOOTSRTAPPED" is not already present then run bootstrapping tasks
if [ ! -f "/var/mdbdata/BOOTSTRAPPED" ]; then
  
  # Move mariadb data directory contents to mounted directory
  mv /var/lib/mysql /var/mdbdata/mysql
  
  # Add file BOOTSTRAPPED to indicate no further bootstrapping needed
  touch  /var/mdbdata/BOOTSTRAPPED

fi

# Enable mariadb service
systemctl enable mariadb.service

# Start mariadb service
systemctl start mariadb.service
