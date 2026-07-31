resource "aws_vpc" "this" {

  cidr_block           = var.cidr_base
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = merge(
    var.tags,
    {
      Name = "${var.application_name}-${var.environment}"
    }
  )
}

resource "aws_internet_gateway" "this" {

  vpc_id = aws_vpc.this.id

  tags = merge(
    var.tags,
    {
      Name = "${var.application_name}-${var.environment}"
    }
  )
}

resource "aws_route_table" "public" {

  vpc_id = aws_vpc.this.id

  tags = merge(
    var.tags,
    {
      Name = "Public${var.application_name}${var.environment}"
    }
  )
}

resource "aws_route_table" "private" {

  vpc_id = aws_vpc.this.id

  tags = merge(
    var.tags,
    {
      Name = "Private${var.application_name}${var.environment}"
    }
  )
}

resource "aws_route" "internet" {

  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.this.id
}

resource "aws_network_acl" "this" {

  vpc_id = aws_vpc.this.id

  tags = merge(
    var.tags,
    {
      Name = "${var.application_name}-${var.environment}"
    }
  )
}

resource "aws_network_acl_rule" "inbound" {

  network_acl_id = aws_network_acl.this.id

  rule_number = 100

  egress = false

  protocol   = "-1"
  rule_action = "allow"

  cidr_block = "0.0.0.0/0"

  from_port = 0
  to_port   = 0
}

resource "aws_network_acl_rule" "outbound" {

  network_acl_id = aws_network_acl.this.id

  rule_number = 100

  egress = true

  protocol   = "-1"
  rule_action = "allow"

  cidr_block = "0.0.0.0/0"

  from_port = 0
  to_port   = 0
}


resource "aws_vpc_endpoint" "s3" {

  vpc_id = aws_vpc.this.id

  service_name = "com.amazonaws.${var.aws_region}.s3"

  vpc_endpoint_type = "Gateway"

  route_table_ids = [
    aws_route_table.public.id,
    aws_route_table.private.id
  ]

  policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Principal = "*"

        Action = [
          "s3:*"
        ]

        Resource = [
          "*"
        ]
      }
    ]
  })
}
