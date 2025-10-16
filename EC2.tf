resource "aws_instance" "mon_instance" {
 ami           = "ami-0341d95f75f311023"
 instance_type = "t2.micro"
}
