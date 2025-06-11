provider "aws" {
    region = "ap-northeast-1"
}

resource "aws_instance" "example" {
    ami = "ami-0febccb66c819dac9" // ubuntu-20.04
    instance_type = "t2.micro"

    tags = {
        Name = "terraform-example"
    }
}
