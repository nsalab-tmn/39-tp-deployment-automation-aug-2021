output "pass" {
  value = {(azuread_user.competitor.user_principal_name) = random_string.pass.result}
}

output "dynamic-params" {
  value = {
    "${var.competition_instance}-${var.prefix}"= {
      "platform-01-public-ip" = azurerm_public_ip.platform-region-01.ip_address
      "platform-02-public-ip" = azurerm_public_ip.platform-region-02.ip_address
      "platform-03-public-ip" = azurerm_public_ip.platform-region-03.ip_address
      "adminuser" = var.adminuser
      "password" = random_string.pass.result
      "ad-username" = azuread_user.competitor.user_principal_name
      "prefix" = "${var.competition_instance}-${var.prefix}"
      "dns-zone" = azurerm_dns_zone.comp-hz.name

    }
  }
}



