#!/bin/sh

# If the file "BOOTSRTAPPED" is not already present then run bootstrapping tasks
if [ ! -f "/var/lib/mysql/BOOTSTRAPPED" ]; then
  
  # Copy mariadb data directory contents to mounted directory
  cp -p -R /usr/local/bootstrap/datadir/mysql/* /var/lib/mysql/
  
  # Add file BOOTSTRAPPED to indicate no further bootstrapping needed
  touch  /var/lib/mysql/BOOTSTRAPPED

fi

# Enable mariadb service
service mariadb enable

# Start mariadb service
service mariadb start
