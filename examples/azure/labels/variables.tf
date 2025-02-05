variable "project" {
  description = "Nome do projeto"
  type        = string
}

variable "environment" {
  description = "Ambiente (dev, prod, etc.)"
  type        = string
}

variable "region" {
  description = "Região onde os recursos serão criados"
  type        = string
}

variable "organization" {
  description = "Nome da organização"
  type        = string
}

variable "CC" {
  description = "Código de custo"
  type        = string
}

variable "CC_OWNER" {
  description = "Proprietário do código de custo"
  type        = string
}

variable "Vertical" {
  description = "Vertical do projeto"
  type        = string
}