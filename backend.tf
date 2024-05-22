terraform {
  backend "s3" {
    bucket = "eksterrabuckethectoruseast1"
    key    = "backend/backend.tfstate"
    region = "us-east-1"
    dynamodb_table = "dynamo-db-tf-state"
  }
}