# fetching output public ip
output "public_ip" {
  description = "fetching public ip of aws instance"
  value       = aws_instance.example.public_ip
}