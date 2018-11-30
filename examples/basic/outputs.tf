# External has results but no idea about plan/apply
# Null understands plan/apply but has no output

output "organizational_units" {
  description = "Organizational units"
  value       = "${module.example.organizational_units}"
}
