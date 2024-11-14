data "aws_secretsmanager_secret" "my_app" {
  name = "dev/my-app/secrets"
}

data "aws_secretsmanager_secret_version" "my_app" {
  secret_id = data.aws_secretsmanager_secret.my_app.id
}

# Reference the value:
# api_key sits inside the secret 'dev/my-app/secrets'

# output "api_key" {
#   value = jsondecode(data.aws_secretsmanager_secret_version.my_app.secret_string)["api_key"]
# }

# output "api_secret" {
#   value = jsondecode(data.aws_secretsmanager_secret_version.my_app.secret_string)["api_secret"]
# }
