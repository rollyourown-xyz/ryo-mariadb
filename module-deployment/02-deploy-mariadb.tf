# SPDX-FileCopyrightText: 2022 Wilfred Nicoll <xyzroller@rollyourown.xyz>
# SPDX-License-Identifier: GPL-3.0-or-later

# Deploy MariaDB for rollyourown projects
#############################################

### Depoy mariadb container
resource "lxd_container" "mariadb" {

  remote     = var.host_id
  name       = "mariadb"
  image      = join("-", [ local.module_id, "mariadb", var.image_version ])
  profiles   = ["default"]
  
  config = { 
    "security.privileged": "false"
    "user.user-data" = file("cloud-init/cloud-init-mariadb.yml")
  }
  
  ## Provide eth0 interface with static IP address
  device {
    name = "eth0"
    type = "nic"

    properties = {
      name           = "eth0"
      network        = var.host_id
      "ipv4.address" = join(".", [ local.lxd_host_network_part, local.mariadb_ip_addr_host_part ])
      "ipv6.address" = join("", [ local.lxd_host_ipv6_prefix, "::", local.lxd_host_network_ipv6_subnet, ":", local.mariadb_ip_addr_host_part ])
    }
  }
  
  ## Mount container directory for mariadb data
  device {
    name = "mariadb-data"
    type = "disk"
    
    properties = {
      source   = join("", ["/var/containers/", local.module_id, "/mariadb/data"])
      path     = "/var/mdbdata"
      readonly = "false"
      shift    = "true"
    }
  }

  ## Mount container directory for mariadb backups
  device {
    name = "mariadb-backups"
    type = "disk"
    
    properties = {
      source   = join("", ["/var/containers/", local.module_id, "/mariadb/backup"])
      path     = "/var/mdbbackup"
      readonly = "false"
      shift    = "true"
    }
  }
}
