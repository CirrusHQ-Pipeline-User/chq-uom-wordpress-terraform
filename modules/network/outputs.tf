output "vpc_id" {

  value = aws_vpc.this.id
}

output "public_route_table_id" {

  value = aws_route_table.public.id
}

output "private_route_table_id" {

  value = aws_route_table.private.id
}

output "network_acl_id" {

  value = aws_network_acl.this.id
}