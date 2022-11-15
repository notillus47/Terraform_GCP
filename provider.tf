terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.3.0"
    }
  }
}

provider "google" {
  project = "terraform-366000"
  region  = "asia-northeast3"
  zone    = "asia-northeast3-a"
}
