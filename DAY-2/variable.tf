
variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = ""
}

variable "ami" {
  description = "AMI ID for the EC2 instance"
  type        = string
  default     = ""

}
 variable "ec2_name" {
  description = "Name tag for the EC2 instance"
  type        = string
  default     = ""
}