variable "container_info" {
  type = object({
    name        = string
    image       = string
    port        = number
    health_path = string
    env         = map(string)
  })
}

variable "config" {
  type = object({
    containers = optional(object({
      cpu           = optional(number)
      memory        = optional(number)
      min_instances = optional(number)
    }))
  })
}

variable "infrastructure" {
  type = object({
    cluster         = string
    security_groups = set(string)
    subnets         = set(string)
  })
}

variable "target_group_arn" {
  type = string
}
