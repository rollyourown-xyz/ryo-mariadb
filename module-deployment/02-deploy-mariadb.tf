# Deploy MariaDB for rollyourown.xyz projects
#############################################

### Depoy mariadb container
resource "lxd_container" "mariadb" {

  remote     = var.host_id
  name       = join("-", [ var.host_id, local.module_id, "mariadb" ])
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
    }
  }
  
  ## Mount container directory for mariadb data
  device {
    name = "mariadb-data"
    type = "disk"
    
    properties = {
      source   = "/var/containers/ryo-mariadb/data"
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
      source   = "/var/containers/ryo-mariadb/backup"
      path     = "/var/mdbbackup"
      readonly = "false"
      shift    = "true"
    }
  }
}
