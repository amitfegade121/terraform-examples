variable ports {
    type = list(number)
    default = [80, 8080, 22]
}

variable "vpc_cidr_block" {
    type = string
}

variable "ami_ids" {
    type = map
    default = {
        "us-east-2" = "ami-002068ed284fb165b"
        "ap-south-1" = "ami-052cef05d01020f1d"
        "us-east-1" = "ami-0ed9277fb7eb570c9"
    }
}

variable "developer_names" {
    type = list(string)
    default = ["alex-ec2-instance", "anna-ec2-instance", "peter-ec2-instance"]
}

