resource "random_password" "db_password" {
  length           = 40
  special          = true
  min_special      = 5
  override_special = "!#$%^&*()-_=+[]{}<>:?"
}

resource "aws_secretsmanager_secret" "db_secrets" {
  name = "/dev/myapp/db-secrets"
}

resource "aws_secretsmanager_secret_version" "db_secrets_version" {
  secret_id = aws_secretsmanager_secret.db_secrets.id

  secret_string = jsonencode(
    {
      username = "db_admin"
      password = random_password.db_password.result
      engine   = "postgresql"
      host     = "postgres-example.rds.amazonaws.com"
    }
  )
}
