# ---------------------------------------------
# Variables
# ---------------------------------------------
variable "project" {
  type    = string
  default = "tastylog"
}

variable "environment" {
  type    = string
  default = "production"
}

variable "username" {
  type      = string
  default   = "admin"
  sensitive = true
}

variable "password" {
  type      = string
  default   = "password"
  sensitive = true
}