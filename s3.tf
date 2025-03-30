resource "aws_s3_bucket" "ios_build_bucket" {
    bucket = "ios-build-artifacts-bucket"
    acl = "private"
    tags = {
        Name = "iOS-Build-Artifacts-Bucket"
        Environment = "ci-cd"
    }
}