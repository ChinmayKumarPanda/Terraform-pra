variable "cidr_block_vpc" {
    description = "cidr of vpc"
    type = string
    default = ""  
}

variable "cidr_blockpub" {
    description = "cidr of pub sub"
   type = string
   default = ""   
}

variable "cidr_blockpvt" {
    description = "cidr of pvt sub"
   type = string
   default = ""   
}


variable "cidr_blocks_SG_PUB" {
    description = "source"
     type = list(string)
     default = [""]
}


variable "cidr_blocks_SG_PVT" {
    description = "source"
     type = list(string)
     default =  [""]
}

variable "ami" {
    description = "ami"
    type = string
    default = ""
  
}

variable "instance_type" {
    description = "type"
    type = string
    default = ""
  
}
