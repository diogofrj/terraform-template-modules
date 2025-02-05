variable "project" {
  description = "Nome do projeto"
  type        = string
  default     = null
}

variable "environment" {
  description = "Ambiente (ex: dev, qa, prod)"
  type        = string
  default     = null
}

variable "region" {
  description = "Região onde os recursos serão criados"
  type        = string
  default     = null
}

variable "organization" {
  description = "Nome da organização"
  type        = string
  default     = null
}

variable "CC" {
  description = "Centro de custo"
  type        = string
  default     = null
}

variable "CC_OWNER" {
  description = "Proprietário do centro de custo"
  type        = string
  default     = null
}

variable "Vertical" {
  description = "Vertical de negócios"
  type        = string
  default     = null
}

variable "create_resource_group" {
  description = "Controla se o grupo de recursos deve ser criado (true) ou usar um existente (false)"
  type        = bool
  default     = true
}

variable "resource_group_name" {
  description = "Nome do grupo de recursos"
  type        = string
}

variable "location" {
  description = "Localização do Azure onde os recursos serão criados"
  type        = string
}

variable "tags" {
  description = "Tags a serem aplicadas aos recursos"
  type        = map(string)
  default     = {}
}