
# resource "aws_route53_zone" "api" {
#   name = "${var.env}.${var.domain_apex}"
# }

##SSL Certificates
# resource "aws_route53_record" "webiste" {
#   for_each = {
#     for dvo in aws_acm_certificate.website.domain_validation_options : dvo.domain_name => {
#       name   = dvo.resource_record_name
#       record = dvo.resource_record_value
#       type   = dvo.resource_record_type
#     }
#   }

#   allow_overwrite = true
#   name            = each.value.name
#   records         = [each.value.record]
#   ttl             = 60
#   type            = each.value.type
#   zone_id         = aws_route53_zone.website.zone_id
# }

# resource "aws_route53_record" "elb" {
#   for_each = {
#     for dvo in aws_acm_certificate.this.domain_validation_options : dvo.domain_name => {
#       name   = dvo.resource_record_name
#       record = dvo.resource_record_value
#       type   = dvo.resource_record_type
#     }
#   }

#   allow_overwrite = true
#   name            = each.value.name
#   records         = [each.value.record]
#   ttl             = 60
#   type            = each.value.type
#   zone_id         = data.aws_route53_zone.this.zone_id
# }

# resource "aws_route53_record" "website_domain" {
#   name    = var.website_domain
#   zone_id = aws_route53_zone.website.id
#   type    = "A"
#   alias {
#     name                   = aws_cloudfront_distribution.website.domain_name
#     zone_id                = aws_cloudfront_distribution.website.hosted_zone_id
#     evaluate_target_health = true
#   }
# }


# resource "aws_route53_record" "alias_route53_record" {
#    zone_id = aws_route53_zone.website.zone_id # Replace with your zone ID
#    name    = "${var.env}.behyve.net"  # Replace with your name/domain/subdomain
#    type    = "A"

#    alias {
#      name                   = aws_lb.backend_servers.dns_name
#      zone_id                = aws_lb.backend_servers.zone_id
#      evaluate_target_health = true
#    }
# }
