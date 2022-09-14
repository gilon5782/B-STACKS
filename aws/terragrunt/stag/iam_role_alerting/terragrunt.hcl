include {
    path = find_in_parent_folders()
}
# Need to change the github source to pesafe
terraform {
    source = "git::git@github.com:bmlltech/aws-infrastructure.git//terraform/roots/iam_role_alerting?ref=${chomp(file("../../stag.versio"))}"
}
# Replace aws account number 36.......
iam_role = "arn:aws:iam::361053095112:role/${get_env("TF_IAM_ROLE_PARENT", "TerraformReadWriteRole")}"

inputs = {
    env = "stag"
}