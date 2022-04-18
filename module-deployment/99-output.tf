# SPDX-FileCopyrightText: 2022 Wilfred Nicoll <xyzroller@rollyourown.xyz>
# SPDX-License-Identifier: GPL-3.0-or-later

# Output variable definitions

output "mariadb_ipv4_address" {
    value       = lxd_container.mariadb.ipv4_address
    description = "IPv4 Address of the mariadb container"
}

output "mariadb_ipv6_address" {
    value       = lxd_container.mariadb.ipv6_address
    description = "IPv6 Address of the mariadb container"
}
