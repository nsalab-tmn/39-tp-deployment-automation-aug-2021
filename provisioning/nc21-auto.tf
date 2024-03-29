resource "random_string" "seed" {
  count = 3
  length           = 16
  special          = false
  min_lower        = 2
  min_numeric      = 2
  min_upper        = 2
  min_special      = 1
  override_special = "+-=%#^@"

}

resource "random_shuffle" "region_octet" {
  input        = range(2, 254)
  keepers = {
    # Generate a new id each time we switch to a new network seedid
    seed_id = random_string.seed[0].id
  }
  result_count = 3
  seed = random_string.seed[0].result
}

resource "random_shuffle" "subnet_octet" {
  input        = range(1, 254)
  keepers = {
    # Generate a new id each time we switch to a new network seedid
    seed_id = random_string.seed[1].id
  }
  result_count = 3
  seed = random_string.seed[1].result
}

resource "random_shuffle" "host_octet" {
  input        = range(10, 254)
  keepers = {
    # Generate a new id each time we switch to a new network seedid
    seed_id = random_string.seed[2].id
  }
  result_count = 2
  seed = random_string.seed[2].result
}

resource "random_integer" "instance_size_index" {
  count = 3
  min = 0
  max = 2
  # keepers = {
  #   # Generate a new integer each time we switch to a new listener ARN
  #   listener_arn = "${var.listener_arn}"
  # }
}

resource "random_integer" "offer_sku_index" {
  count = 3
  min = 0
  max = 1
  # keepers = {
  #   # Generate a new integer each time we switch to a new listener ARN
  #   listener_arn = "${var.listener_arn}"
  # }
}


module "competion" {
    source = "./terraform"
    count = 15
    prefix = format("comp-%02d", count.index+1)
    deploy_routes = true
    deploy_dns_a_records = true
    deploy_custom_data = false
    assets_path = "assets"
    region-01_default_route = true
    competition_instance = "gfd-39"
    region_octets = random_shuffle.region_octet.result
    subnet_octets = random_shuffle.subnet_octet.result
    host_octets = random_shuffle.host_octet.result
    instance_size_indexes = random_integer.instance_size_index.*.result
    offers_skus_indexes = random_integer.offer_sku_index.*.result
}

output "seeds" {
  value = random_string.seed.*.result
}

output "passwords" {
  value =  module.competion.*.pass 
}

output "dynamic-params" {
  value = merge(module.competion.*.dynamic-params...)
}
