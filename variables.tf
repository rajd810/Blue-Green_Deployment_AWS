variable "aws_region" {
    description = "AWS Region to launch servers"
    default = "us-east-1"
}

variable "aws_access_key" {
    description = "AWS user access key"
    default = "XXXXX"
}

variable "aws_secret_key" {
    description = "AWS user secret key"
    default = "XXXX"
}

variable "aws_amis" {
    default = {
        us-east-1 = ""
        eu-west-2 = ""
    }
}

variable "instance_type" {
    description     = "Type of AWS EC2 Instance"
    default         = "t2.micro"
}

variable "public_key_path" {
    description = "Enter the path to the SSH Public Key to add to AWS"
    default     = "t2.micro"
}

variable "key_name" {
    description = "AWS Key Name"
    default     = "name of keypair"
}

variable "instance_count" {
    default = 1
}
