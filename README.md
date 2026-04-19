# Elastic MCP Multi-Agent Demo
## Contents
1.  [Summary](#summary)
2.  [Architecture](#architecture)
3.  [Features](#features)
4.  [Prerequisites](#prerequisites)
5.  [Installation](#installation)
6.  [Usage](#usage)

## Summary <a name="summary"></a>
This is a demonstration of integration of Elastic MCP tools to multiple third party Agentic AI frameworks.

## Architecture <a name="architecture"></a>
![architecture](assets/arch.jpg) 


## Features <a name="features"></a>
- Jupyter notebook
- Builds an Elastic Serverless deployment via Terraform
- Indexes a synthetic data set consisting of a product catalog and product reviews.
- Creates Elastic MCP search tools via API
- Integrates those MCP tools to three different Agentic AI environments:  Google ADK, LangGraph and CrewAI
- Deletes the entire deployment via Terraform

## Prerequisites <a name="prerequisites"></a>
- terraform
- Elastic Cloud account and API key
- OpenAI API key
- Anthropic API key
- GCP project
- Python

## Installation <a name="installation"></a>
- Edit the terraform.tfvars.sample and rename to terraform.tfvars
- Create a Python virtual environment

## Usage <a name="usage"></a>
- Execute notebook