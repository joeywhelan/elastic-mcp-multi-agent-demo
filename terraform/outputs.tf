output "elastic_cloud_id" {
  value = ec_elasticsearch_project.demo_project.cloud_id
}

output "kibana_url" {
  value = ec_elasticsearch_project.demo_project.endpoints.kibana
}

output "elastic_cloud_api_key" {
  value = var.elastic_cloud_api_key
  sensitive = true
}

output "openai_api_key" {
  value = var.openai_api_key
  sensitive = true
}

output "anthropic_api_key" {
  value = var.anthropic_api_key
  sensitive = true
}

output "google_cloud_project" {
  value = var.google_cloud_project
  sensitive = true
}

output "google_cloud_location" {
  description = "The formatted region without the gcp- prefix and trailing numbers"
  value       = trimprefix(var.region, "gcp-")
}