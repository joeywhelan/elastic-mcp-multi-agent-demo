# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Demo project showcasing **Google ADK (Vertex AI)** orchestrating AI agents that connect via **Model Context Protocol (MCP)** to **Elasticsearch** for an e-commerce product search use case. The architecture uses a dual-index pattern (products + reviews) where the ADK agent chains MCP-exposed Elasticsearch tools to answer multi-part queries.

## Architecture

- **Terraform** (`terraform/`) provisions an Elastic Cloud Serverless project using `elastic/ec` and `elastic/elasticstack` providers
- **Jupyter notebook** (`demo.ipynb`) is the main entrypoint — runs the full demo end-to-end:
  1. Provisions Elastic Serverless via Terraform
  2. Populates `.env` from Terraform outputs (`ELASTIC_CLOUD_API_KEY`, `ELASTIC_CLOUD_ID`, `KIBANA_URL`)
  3. Indexes product catalog (1000 docs) and customer reviews (8462 docs) into separate Elasticsearch indices
  4. Creates two MCP tools via the Kibana Agent Builder API (`/api/agent_builder/tools`):
     - `search_products` — ES|QL query using MATCH + semantic_text + FUSE + RERANK (Jina reranker)
     - `get_reviews` — ES|QL term query on `product_id`
  5. Assembles a Google ADK agent on Vertex AI with MCP tools + local tools
  6. Tears down infrastructure

## Key Data Files

- `products.jsonl` — 1000 product documents (product_id, name, description, category, price, stock_count)
- `reviews.jsonl` — 8462 review documents (product_id, review, stars, review_date)

## Elasticsearch Index Schemas

- **`products`**: `product_id` (keyword), `name` (text), `description` (text + semantic_text subfield), `category` (keyword), `price` (float), `stock_count` (integer)
- **`reviews`**: `product_id` (keyword), `review` (text + semantic_text subfield), `stars` (integer), `review_date` (date)

## Commands

```bash
# Setup
python -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt

# Terraform (requires elastic_cloud_api_key in terraform/terraform.tfvars)
terraform -chdir=terraform init -upgrade
terraform -chdir=terraform apply -auto-approve
terraform -chdir=terraform destroy -auto-approve

# Run the notebook
jupyter notebook demo.ipynb
```

## Environment Variables

Copy `.env.example` to `.env`. The notebook auto-generates `.env` from Terraform outputs, but for manual setup:
- `ELASTIC_CLOUD_API_KEY` — Elastic Cloud API key
- `ELASTIC_CLOUD_ID` — Cloud ID for the Elastic deployment
- `KIBANA_URL` — Kibana endpoint URL

Terraform requires `elastic_cloud_api_key` in `terraform/terraform.tfvars` (see `terraform/terraform.tfvars.sample`).
