output "arn" {
  value = aws_acm_certificate.acm.arn
}

output "acm_certificate_domain_validation_options" {
  value = aws_acm_certificate.acm.domain_validation_options
}

# output "validation_record_name" {
#   value = aws_acm_certificate.acm.domain_validation_options[0].resource_record_name
#   description = "The name of the DNS record for ACM certificate validation."
# }


# output "validation_record_value" {
#   value = aws_acm_certificate.acm.domain_validation_options.resource_record_value
#   description = "The value of the DNS record for ACM certificate validation."
# }