output "userpool_id" {
  value = aws_cognito_user_pool.bmb_user_pool.id
}

output "api_client_id" {
  value = aws_cognito_user_pool_client.bmb_api_client.id
}

output "arn" {
  value = aws_cognito_user_pool.bmb_user_pool.arn
}