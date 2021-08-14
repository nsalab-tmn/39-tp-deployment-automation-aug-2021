variable "location_01" {
  default = "westus2"
  type = string
}

variable "location_02" {
  default = "westcentralus"
  type = string
}

variable "location_03" {
  default = "southcentralus"
  type = string
}

variable "prefix" {
  default = "comp-99"
  type = string
}

variable "competition_instance" {
  default = "auto39"
  type = string
}
variable "adminuser" {
  default = "azadmin"
  type = string
}

variable "prod_rg" {
  default = "nsalab-prod"
  type = string
}

variable "deploy_custom_data" {
  default = false
  type = bool
}

variable "deploy_routes" {
  default = false
  type = bool
}

variable "deploy_dns_a_records" {
  default = false
  type = bool
}

variable "assets_path" {
  type = string
  default = "assets"
  validation {
    condition     = (var.assets_path == "assets" ||  
      var.assets_path == "assets-tshoot") 
    error_message = "The assets_path variable must be equal to `assets` or `assets-tshoot`."
  }
  description = "The assets path for custom data. It works only if deploy_custom_data variable is set."
}

variable "region-01_default_route" {
  default = true
  type = bool
  description = "Set this variable only when finished custom_data deployment"

}

variable "region_octets" {
  type    = list(string)
  default = ["1", "2", "3"]
  validation {
    condition     = (length(var.region_octets) == 3 && 
      tonumber(var.region_octets[0]) > 0 && tonumber(var.region_octets[0]) < 255 &&
      tonumber(var.region_octets[1]) > 0 && tonumber(var.region_octets[1]) < 255 &&
      tonumber(var.region_octets[2]) > 0 && tonumber(var.region_octets[2]) < 255 &&
      tonumber(var.region_octets[0]) != tonumber(var.region_octets[1]) &&
      tonumber(var.region_octets[0]) != tonumber(var.region_octets[2]) &&
      tonumber(var.region_octets[1]) != tonumber(var.region_octets[2])       
      ) 
    error_message = "The region_octets  list must have 3 different items 0<item<255."
  }
}

variable "subnet_octets" {
  type    = list(string)
  default = ["1", "10", "99"]
    validation {
    condition     = (length(var.subnet_octets) == 3 && 
      tonumber(var.subnet_octets[0]) > 0 && tonumber(var.subnet_octets[0]) < 255 &&
      tonumber(var.subnet_octets[1]) > 0 && tonumber(var.subnet_octets[1]) < 255 &&
      tonumber(var.subnet_octets[2]) > 0 && tonumber(var.subnet_octets[2]) < 255 &&
      tonumber(var.subnet_octets[0]) != tonumber(var.subnet_octets[1]) &&
      tonumber(var.subnet_octets[0]) != tonumber(var.subnet_octets[2]) &&
      tonumber(var.subnet_octets[1]) != tonumber(var.subnet_octets[2])       
      ) 
    error_message = "The subnet_octets  list must have 3 different items 0<item<255."
  }
}

variable "host_octets" {
  type    = list(string)
  default = ["4", "6"]
  validation {
    condition     = (length(var.host_octets) == 2 && 
      tonumber(var.host_octets[0]) > 0 && tonumber(var.host_octets[0]) < 255 &&
      tonumber(var.host_octets[1]) > 0 && tonumber(var.host_octets[1]) < 255 &&
      tonumber(var.host_octets[0]) != tonumber(var.host_octets[1])      
      ) 
    error_message = "The host_octets  list must have 2 different items 0<item<255."
  }
}


locals {
  instance_sizes = ["Standard_B2s", "Standard_B1s", "Standard_B1ms"]
  offers_skus = [ 
    {
      offer= "0001-com-ubuntu-server-focal"
      sku = "20_04-lts"
    },
    {
      offer = "UbuntuServer"
      sku = "18.04-LTS"
    }
  ]
}

variable instance_size_indexes {
  type = list(number)
  default = [0, 1, 2]
  validation {
    condition = (length(var.instance_size_indexes) == 3 &&
      var.instance_size_indexes[0] >=0 && var.instance_size_indexes[0] <=2 &&
      var.instance_size_indexes[1] >=0 && var.instance_size_indexes[1] <=2 &&
      var.instance_size_indexes[2] >=0 && var.instance_size_indexes[2] <=2
    )
    error_message = "The instace_size_indexes  list must have 3  items  with 0<=item<=2."
  }
}

variable offers_skus_indexes {
  type = list(number)
  default = [0, 1, 0]
  validation {
    condition = (length(var.offers_skus_indexes) == 3 &&
      var.offers_skus_indexes[0] >=0 && var.offers_skus_indexes[0] <=1 &&
      var.offers_skus_indexes[1] >=0 && var.offers_skus_indexes[1] <=1 &&
      var.offers_skus_indexes[2] >=0 && var.offers_skus_indexes[2] <=1
    )
    error_message = "The offers_skus_indexes  list must have 3  items  with 0<=item<=1."
  }
}