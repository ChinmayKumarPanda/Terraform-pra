variable "ami" {
  description = "The AMI to use for the instance"
  type =string 
  default     = ""   
  
}
variable "instance_type" {
  description = "The type of instance to use"
  type = string
  default     = ""
  
}
variable "tags" {
  description = "Name of the instance"
 type = string
 default = "" 
}