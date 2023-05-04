terraform {
 backend "s3" {
   bucket         = "test-lambda-99"
   key            = "state/terraform.tfstate"
   region         = "ap-south-1"
   encrypt        = true
   kms_key_id     = "alias/terraform-bucket-key"
 }
}
