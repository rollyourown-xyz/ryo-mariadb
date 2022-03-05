# SPDX-FileCopyrightText: 2022 Wilfred Nicoll <xyzroller@rollyourown.xyz>
# SPDX-License-Identifier: GPL-3.0-or-later

# Output variable definitions

output "mariadb_ip_address" {
    value       = lxd_container.mariadb.ip_address
    description = "IP Address of the mariadb container"
}
