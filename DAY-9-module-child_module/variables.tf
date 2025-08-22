variable "ami" {
    type = string
    default = ""
  
}
variable "instance_type" {
    type = string
    default = ""
  
}
variable "tags" {
    type = string
    default = ""
  
}


variable "s3" {
    type = string
    default = ""
  
}

variable "cidr_block" {
    type = string
    default = ""
  
}
variable "cidr_blocks" {
    type = string
    default = ""
  
}


variable "tags_vpc" {
    type = string
    default = ""
  
}

variable "tags_subnet" {
    type = string
    default = ""
  
}


variable "db_identifier" {
  description = "RDS instance identifier"
  type        = string
  default     = ""
}

variable "db_username" {
  description = "Master username"
  type        = string
  default     = ""
}

variable "db_password" {
  description = "Master password"
  type        = string
  default = ""
}