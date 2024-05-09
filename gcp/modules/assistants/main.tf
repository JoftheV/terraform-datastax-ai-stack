module "assistants_api_db" {
  source         = "../astra_db"
  cloud_provider = var.infrastructure.cloud_provider

  config = {
    name                = "assistant_api_db"
    keyspace            = "assistant_api"
    regions             = var.config.db.regions
    deletion_protection = try(coalesce(var.config.db.deletion_protection), null)
    cloud_provider      = try(coalesce(var.config.db.cloud_provider), null)
  }
}

locals {
  container_info = {
    name  = "astra-assistants"
    image = "datastax/astra-assistants:v0.1.17"
    port  = 8000
  }
}

output "container_info" {
  value = local.container_info
}

module "cloud_run_deployment" {
  source         = "../cloud_run_deployment"
  container_info = local.container_info
  config         = var.config
  infrastructure = var.infrastructure
}
