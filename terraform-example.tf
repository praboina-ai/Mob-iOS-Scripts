#Terraform Based macOS EC2 Setup

provider "aws" {
  region = "us-west-2"
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
}

provider "aws_instance" "mac_builder" {
   ami = "ami-0c55b159cbfafe1f0"
   instance_type = "mac1.metal"
   key_name = "ios-build-key"

    root_block_device {
      volume_size = 1000 #1000 GB for macosbuild machine
    }
    
      tags = {
            Name = "iOS-Build-Server"
            Environment = "ci-cd"
      }

      security_groups = ["${aws_security_group.ios_build_sg.id}"]

      provisioner "local-exec" {
        command = "echo 'Hello, World!'"
      }

      provisioner "remote-exec" {
        inline = [
          "echo 'Hello, World!'",
          "sudo softwareupdate -i -a"
          "curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash"
          "brew install fastlane"
          "brew install xctool"
          "gem install bundler"
          "gem install cocoapods"

        ]
      }

        connection {
            type = "ssh"
            user = "ec2-user"
            private_key = file("~/.ssh/ios-build-key.pem")
            host = self.public_ip

        }
}


