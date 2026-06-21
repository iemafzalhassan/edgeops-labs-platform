# Azure Dev environment terraform state backend configuration.
# For a production setup, we would use Azure Blob Storage, but for initial dev we use local.
terraform {
  backend "local" {
    path = "terraform.tfstate"
  }
}
