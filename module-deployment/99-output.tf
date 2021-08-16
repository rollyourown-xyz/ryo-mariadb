# Output variable definitions

output "mariadb_ip_address" {
    value       = lxd_container.mariadb.ip_address
    description = "IP Address of the mariadb container"
}
