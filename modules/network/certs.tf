# resource "aws_acm_certificate" "website" {
#   provider          = aws.use1
#   domain_name       = var.website_domain
#   validation_method = "DNS"
# }


# resource "aws_acm_certificate_validation" "website" {
#   provider                = aws.use1
#   certificate_arn         = aws_acm_certificate.website.arn
#   validation_record_fqdns = [for record in aws_route53_record.website : record.fqdn]
# }



# resource "aws_acm_certificate" "elb" {
#   domain_name       = "${var.env}.${var.domain_apex}}"
#   validation_method = "DNS"
# }



# resource "aws_acm_certificate_validation" "elb" {
#   certificate_arn         = aws_acm_certificate.this.arn
#   validation_record_fqdns = [for record in aws_route53_record.elb : record.fqdn]
# }