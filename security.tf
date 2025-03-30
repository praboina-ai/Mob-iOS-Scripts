resource "aws_security_group" "ios_build_sg" {
    name_prefix = "ios_build_sg"
    vpc_id = "${var.vpc_id}"
    tags = {
        Name = "iOS-Build-Server-SG"
        Environment = "ci-cd"
    }
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"] #Allow SSH from anywhere
  
}