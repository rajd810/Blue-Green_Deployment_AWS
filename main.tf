provider "aws" {
    aws_access_key              = var.aws_access_key
    aws_secret_key              = var.aws_secret_key
    Region                      = var.aws_region
    skip_credentials_validation = true
}

resource "aws_security_group" "allow_ports"{
    name                        = "allow_ssh_http"
    description                 = "Allow inbound SSH traffic and http from any IP"
    vpc_id                      = "${module.vpc.vpc_id}"

    #SSH Ingress
    ingress {
        from_port               = 22
        to_port                 = 22
        protocol                = "tcp"
        #RESTRICT INGRESS TO NECCESSARY IPS/PORTS
        cidr_blocks             = ["0.0.0.0/0"]
    
    #HTTP ACCESS
    ingress {
        from_port               = 80
        to_port                 = 80
        protocol                = "tcp"
        #RESTRICT INGRESS TO NECCESSARY IPS/PORTS
        cidr_blocks             = ["0.0.0.0/0"]
    }

    egress {
        from_port               = 0
        to_port                 = 0
        protocol                = "-1"
        cidr_blocks             = ["0.0.0.0/0"]
    }

    tags {
        Name                    = "Allow SSH and HTTP"
    }
}

resource "aws_instance" "webserver" {
    instance_type               = "${var.instance_type}"
    ami                         = "${lookup(var.aws_amis, var.aws_region)}"
    count                       = "${var.instance_count}"
    key_name                    = "${var.key_name}"
    vpc_security_group_ids      = ["${aws_security_group.allow_ports.id}"]
    subnet_id                   = "${element(module.vpc.public_subnets,count.index)}"
    user_data                   = "${file("scripts/init.sh")}"

    tags {
        Name    = "Webserver"
    }
}
