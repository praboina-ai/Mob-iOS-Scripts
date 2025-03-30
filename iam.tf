resource "aws_iam_role" "ios_builder_role" {
    name = "ios_builder_role"
    assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "codebuild.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_instance_profile" "ios_builder_profile" {
    name = "ios_builder_profile"
    role = "${aws_iam_role.ios_builder_role.name}"
}