resource "aws_cognito_user_pool" "bmb_user_pool" {
  name                     = var.user_pool_name
  auto_verified_attributes = ["email"]

  schema {
    attribute_data_type      = "String"
    developer_only_attribute = false
    mutable                  = false
    name                     = "name"
    required                 = true
  }
  schema {
    attribute_data_type      = "String"
    developer_only_attribute = false
    mutable                  = false
    name                     = "email"
    required                 = true
  }

  tags = {
    Terraform = "true"
  }
}

resource "aws_cognito_user_pool_client" "bmb_test_client" {
  name         = "bmb test client"
  user_pool_id = aws_cognito_user_pool.bmb_user_pool.id
  supported_identity_providers = compact([
    "COGNITO",
  ])
  callback_urls                        = ["https://postech.fiap.com.br/curso/software-architecture/"]
  allowed_oauth_flows_user_pool_client = true
  allowed_oauth_flows                  = ["code", "implicit"]
  allowed_oauth_scopes                 = ["email", "openid"]
}

resource "aws_cognito_identity_pool" "bmb_identity_pool" {
  identity_pool_name               = "${var.user_pool_name}_identity"
  allow_unauthenticated_identities = false
  cognito_identity_providers {
    client_id               = aws_cognito_user_pool_client.bmb_test_client.id
    provider_name           = aws_cognito_user_pool.bmb_user_pool.endpoint
    server_side_token_check = false
  }

  tags = {
    Terraform = "true"
    TCManaged = "true"
  }
}

resource "aws_cognito_identity_pool_provider_principal_tag" "identity_provider_tags" {
  identity_pool_id       = aws_cognito_identity_pool.bmb_identity_pool.id
  identity_provider_name = aws_cognito_user_pool.bmb_user_pool.endpoint
  use_defaults           = false
  principal_tags = {
    test = "value"
  }
}

resource "aws_cognito_user_pool_domain" "main" {
  domain       = var.user_pool_name
  user_pool_id = aws_cognito_user_pool.bmb_user_pool.id
}

resource "aws_cognito_user_group" "admin" {
  name         = "admin"
  user_pool_id = aws_cognito_user_pool.bmb_user_pool.id
  description  = "Administrator"
}

resource "aws_cognito_user_group" "kitchen" {
  name         = "kitchen"
  user_pool_id = aws_cognito_user_pool.bmb_user_pool.id
  description  = "Kitchen staff"
}

resource "aws_cognito_user" "kitchen_user" {
  username                 = "25297503000"
  user_pool_id             = aws_cognito_user_pool.bmb_user_pool.id
  message_action           = "SUPPRESS"
  password                 = "TempPass123!"

  attributes = {
    name           = "Cozinha"
    email          = "cozinha@techchallenge.com"
    email_verified = true
  }
}

resource "aws_cognito_user" "admin_user" {
  username                 = "32747126048"
  user_pool_id             = aws_cognito_user_pool.bmb_user_pool.id
  message_action           = "SUPPRESS"
  password                 = "TempPass123!"

  attributes = {
    name           = "Admin"
    email          = "admin@techchallenge.com"
    email_verified = true
  }
}

resource "aws_cognito_user" "customer_user" {
  username                 = "91121682030"
  user_pool_id             = aws_cognito_user_pool.bmb_user_pool.id
  message_action           = "SUPPRESS"
  password                 = "TempPass123!"

  attributes = {
    name           = "Customer"
    email          = "customer@techchallenge.com"
    email_verified = true
  }
}