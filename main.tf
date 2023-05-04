
provider "aws" {
    region  = "ap-south-1"
}

provider "archive" {}

data "archive_file" "lambda" {
  type        = "zip"
  source_dir  = "../lambda"
  output_path = "lambda.zip"
}

data "aws_iam_policy_document" "AWSLambdaTrustPolicy" {
  version = "2012-10-17"
  statement {
    actions = ["sts:AssumeRole"]
    effect  = "Allow"
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "iam_role" {
  assume_role_policy = data.aws_iam_policy_document.AWSLambdaTrustPolicy.json
  name               = DevOps-Candidate-Lambda-Role
}

resource "aws_lambda_function" "lambda_function" {

  filename                = index.js
  function_name           = lambda-function
  role                    = aws_iam_role.iam_role.arn
  handler                 = "index.handler"
  runtime                 = "nodejs14.x"
  source_code_hash        = filebase64sha256(data.archive_file.lambda.output_path)

  vpc_config {
    subnet_ids         = [aws_subnet.subnet_private.id]
    security_group_ids = [aws_default_security_group.default_security_group.id]
  }

}



resource "aws_subnet" "subnet_private" {
  vpc_id                  = vpc-00bf0d10a6a41600c
  cidr_block              = var.subnet_private_cidr_block
  map_public_ip_on_launch = false
  
}

resource "aws_route_table" "route_table_private" {
  vpc_id = vpc-00bf0d10a6a41600c

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = nat-089afc4a1054d134c
  }

  
}

resource "aws_route_table_association" "route_table_association_private" {
  subnet_id      = aws_subnet.subnet_private.id
  route_table_id = aws_route_table.route_table_private.id
}

resource "aws_default_security_group" "default_security_group" {
  vpc_id = aws_vpc.vpc.id

  ingress {
    protocol  = -1
    self      = true
    from_port = 0
    to_port   = 0
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
   }

 
}



resource "aws_iam_role_policy_attachment" "iam_role_policy_attachment_lambda_vpc_access_execution" {
  role       = DevOps-Candidate-Lambda-Role
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole"
}





resource "aws_s3_bucket" "terraform-state" {
 bucket = "test-lambda-99"
 acl    = "private"

 versioning {
   enabled = true
 }

 server_side_encryption_configuration {
   rule {
     apply_server_side_encryption_by_default {
       kms_master_key_id = aws_kms_key.terraform-bucket-key.arn
       sse_algorithm     = "aws:kms"
     }
   }
 }
}

resource "aws_s3_bucket_public_access_block" "block" {
 bucket = aws_s3_bucket.terraform-state.id

 block_public_acls       = true
 block_public_policy     = true
 ignore_public_acls      = true
 restrict_public_buckets = true
}






