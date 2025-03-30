resource "aws_instance" "mac_builder" {
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

    provisioner "local-exec" {
      command = "ansible-playbook -i inventory.ini setup-mac.yml"
    }