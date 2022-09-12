# Bucket name and dynamodb are just placeholders. Once s3 bucket for terraformstate is setup, insert names where relevant.
remote_state {
    backend = "s3"
    config  = {
        bucket          = "bucketname.tfstate.${basename(dirname(get_terragrunt_dir()))}"
        key             = "${basename(path_relative_to_include())}/${basename(path_relative_to_include())}.tfstate"
        region          = "eu-west-2"
        encrypt         = true
        dynamodb_table  = "dynamodbname.tfstate.${basename(dirname(get_terragrunt_dir()))}.tflock"
    }
}

terraform {
    after_hook "copy_required_providers" {
        commands = ["init-from-module"]
        execute  = ["cp", "${get_parent_terragrunt_dir()}/../terraform/required_providers.tf", "."]
    }

    after_hook "copy_terraform_lock_file" {
        commands = ["init-from-module"]
        execute  = ["cp", "-a", "${get_parent_terragrunt_dir()}/../terraform/.terraform.lock.hcl", "."]
    }
}
