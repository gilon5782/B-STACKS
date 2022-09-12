terraform {
    required_providers {
        aws = {
            source  = "hashicorp/aws"
            version = "~> 4.18"
        }

        random = {
            source  = "hashicorp/random"
            version = "~> 3.3"
        }

        external = {
            source = "hashicorp/external"
            version = "~> 1.2"
        }

        template = {
            source  = "hashicorp/template"
            version = "~> 2.2"
        }

        archive = {
            source  = "hashicorp/archive"
            version = "~> 1.3" 
        }

        local = {
            source  = "hashicorp/local"
            version = "~> 2.1"
        }

        null = {
            source  = "hashicorp/null"
            version = "~> 2.1"
        }

    }
    required_version = "~> 1.1"
}

provider "aws" {
    region      = "eu-west-2"
    max_retries = 25        
}