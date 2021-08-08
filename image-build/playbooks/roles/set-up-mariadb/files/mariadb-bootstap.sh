#!/bin/sh

# If the file "BOOTSRTAPPED" is not already present then run bootstrapping tasks
if [ ! -f "/var/lib/mysql/BOOTSTRAPPED" ]; then
  
  # Move mariadb data directory contents to mounted directory
  mv /usr/local/bootstrap/datadir/* /var/lib/mysql/
  
  # Add file BOOTSTRAPPED to indicate no further bootstrapping needed
  touch  /var/lib/mysql/BOOTSTRAPPED

fi

# Enable mariadb service
service mariadb enable

# Start mariadb service
service mariadb start
