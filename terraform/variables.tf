variable "elastic_cloud_api_key" {
  description = "Elastic Cloud API key with Cloud and Stack access"
  type        = string
  sensitive   = true
}

variable "openai_api_key" {
  description = "OpenAI API key"
  type        = string
  sensitive = true
}

variable "anthropic_api_key" {
  description = "Anthropic API key"
  type        = string
  sensitive   = true
}

variable "region" {
  description = "GCP region"
  type        = string  
  default     = "gcp-us-central1"
}

variable "google_cloud_project" {
  description = "GCP project"
  type        = string  
  sensitive    = true
}