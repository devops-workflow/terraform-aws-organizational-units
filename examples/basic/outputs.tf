# External has results but no idea about plan/apply
# Null understands plan/apply but has no output

output "ids" {
  description = "Root and Organizational units IDs"
  value       = "${module.example.ids}"
}
