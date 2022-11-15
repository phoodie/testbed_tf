variable "server_port" {
  description = "default port for server"
  type        = number
  default     = 8080
  # if "default" isn't specified, you will be prompted
  # Also you can forcefully apply with "terraform plan -var "server_port=8080"
}

variable "security_group_name" {
  description = "The name of the security group"
  type        = string
  default     = "terraform-example-instance"
}