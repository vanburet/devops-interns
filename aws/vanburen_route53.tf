resource "aws_acm_certificate" "vanburen_acm_certtificate" {
  domain_name       = "jenkins.vanburen.bastionhost.intern.aws.labshare.org"
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}

data "aws_route53_zone" "vanburen_selected" {
  name         = "jenkins.vanburen.bastionhost.intern.aws.labshare.org"
  private_zone = true
}

resource "aws_route53_record" "vanburen_route53" {
  for_each = {
    for dvo in aws_acm_certificate.example.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = data.aws_route53_zone.vanburen_selected.zone_id
}

resource "aws_acm_certificate_validation" "vanburen_cert_validation" {
  certificate_arn         = aws_acm_certificate.pvanburen_acm_certtificate.arn
  validation_record_fqdns = [for record in aws_route53_record.vanburen_route53 : record.fqdn]
}
