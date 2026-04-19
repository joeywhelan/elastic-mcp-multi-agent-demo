

# `plan.md`: Elastic MCP Dual-Index (Catalog + Reviews) & Google ADK Demo

## 1. Project Objective
Generate a complete Python environment and Jupyter Notebook demonstrating an enterprise-grade AI architecture using the **MCP Tool Provider** pattern. 

The demo will showcase **Google ADK (Vertex AI)** acting as the intelligence orchestrator, connecting via the Model Context Protocol (MCP) to **Elasticsearch**. 

**Architectural Focus:** To demonstrate realistic enterprise data modeling and forced tool chaining, the Elasticsearch backend will use a **Dual-Index Architecture** separating static product catalogs from user-generated reviews. The Google ADK agent must dynamically chain tools mapped to these distinct indices to successfully answer a multi-part user query requiring product comparison.



## 2. Directory Structure to Create
The CLI should generate the following files in the project root:
* `requirements.txt`
* `.env.example`
* `01_setup_workspace_tech_data.py`
* `02_adk_mcp_product_researcher.ipynb`

---

## 3. Step-by-Step Execution Plan

### Step 1: Environment & Dependencies
**Action:** Generate the dependency and environment files.
* **`requirements.txt`:** Include standard data science libraries (`pandas`, `jupyter`), Google AI libraries (`google-cloud-aiplatform` and the specific ADK library), and MCP client libraries (`mcp`, `httpx`). *Include `elasticsearch` and `faker` only for the data setup script.*
* **`.env.example`:** * `GOOGLE_CLOUD_PROJECT`
    * `GOOGLE_CLOUD_LOCATION`
    * `ELASTIC_KIBANA_URL`
    * `ELASTIC_API_KEY`
    * `ELASTIC_MCP_SERVER_URL`

### Step 2: Data Setup & Tool Provisioning Concept (`01_setup_workspace_tech_data.py`)
**Action:** Write a Python script to seed **two separate** Elasticsearch indices to reflect a real-world e-commerce architecture.
* **Generate Mock Data:** * **Index 1 (`product-catalog`):** Generate ~20 home office products (e.g., mechanical keyboards, ergonomic mesh chairs, ultra-wide monitors). Include `product_id`, `name`, `description` (rich text detailing features), `category`, and `price`.
    * **Index 2 (`customer-reviews`):** Generate 3-5 mock reviews for each `product_id`. Include `product_id`, `review_text` (e.g., "The switches are incredibly quiet, perfect for my open office"), `rating`, and `helpful_votes`.
* **Ingestion:** Bulk index the respective datasets into their specific indices.
* **The Tool Contract (Crucial Comments):** Add a large comment block at the bottom explaining the required Elastic MCP server configuration and Python wrapper logic:
    1.  `elastic_semantic_product_search(query: str)`: Executes a semantic/vector search exclusively against the `product-catalog` index. **Must return the Top 3 matches** (ID, name, and description) to allow the LLM to compare options.
    2.  `elastic_get_product_reviews(product_id: str)`: Executes a strict Term Query against the `customer-reviews` index, filtered by the provided ID, sorting by `helpful_votes` descending. It must parse the raw JSON and return a clean, plain-text string of the top 5 reviews to save token space.

### Step 3: The Core Demo Notebook (`02_adk_mcp_product_researcher.ipynb`)
**Action:** Generate a Jupyter Notebook blending Markdown narrative and executable Python cells.

* **Cell 1: Setup & Concept Overview**
    * Load the `.env` file.
    * Initialize Vertex AI and the Google A# `plan.md`: Elastic MCP Tool Provider + Google ADK E-Commerce Demo

## 1. Project Objective
Generate a complete Python environment and Jupyter Notebook demonstrating an enterprise-grade AI architecture using the **MCP Tool Provider** pattern. 

The demo will showcase **Google ADK (powered by Vertex AI)** acting as the sole intelligence engine. It will connect via the Model Context Protocol (MCP) to **Elasticsearch**, which acts purely as a secure host for purpose-built database tools (e.g., semantic search, inventory checks). 

The use case is an "AI Personal Shopper & Inventory Analyst" for an outdoor gear retailer.

## 2. Directory Structure to Create
The CLI should generate the following files in the project root:
* `requirements.txt`
* `.env.example`
* `data.json`
* `demo.ipynb`

## 3. Step-by-Step Execution Plan

### Step 1: Environment & Dependencies (`requirements.txt` & `.env.example`)
**Action:** Generate the dependency and environment files.
* **`requirements.txt`:** Must include standard data science libraries (`pandas`, `jupyter`), Google AI libraries (`google-cloud-aiplatform` and ADK-specific dependencies), and MCP client libraries (`mcp`, `httpx`). *Include `elasticsearch` only for the data setup script.*
* **`.env.example`:** Create a template for environment variables:
    * `GOOGLE_CLOUD_PROJECT`
    * `GOOGLE_CLOUD_LOCATION`
    * `ELASTIC_KIBANA_URL`
    * `ELASTIC_API_KEY`

### Step 2: Data Setup & Tool Provisioning Concept (`data.json`)
**Action:** Generate JSON data
* **Generate Mock Data:** Create a catalog of 100 outdoor products (tents, sleeping bags, jackets). Each product will have a JSON document consisting of the following:
    * `product_id`, `name`, `description` (rich text for semantic search).
    * `category`, `price`, `stock_count` (numeric/keyword for aggregations).
Save the products to a file called data.json

### Step 3: The Core Demo Notebook (`demo.ipynb`)
**Action:** Generate a Jupyter Notebook blending Markdown narrative and executable Python cells.

* **Cell 1: Environment Creation**
    * Terraform Elastic Serverless Project creation.  Do not implement this 

* **Cell 2: Elastic MCP Tool Creation**
    * Create an Elastic python client
    * Using the Elastic Kibana agent builder api, create 2 MCP Tools - Semantic Product Search and Check Inventory

* **Cell 3: Define Local ADK Tools**
    * Create a mock local Python tool to demonstrate ADK's ability to combine remote database tools with local actions.
    * *Example:* `tool_calculate_shipping(zip_code: str, weight_lbs: float)` which returns a mock shipping cost and delivery date.

* **Cell 4: Assemble the ADK Lead Agent**
    * Instantiate the main Google ADK Agent using a Gemini model.
    * Equip the agent's tool registry with both the remote tools discovered via the MCP client *and* the local shipping tool.
    * Deploy the Lead Agent on Vertex.ai

* **Cell 5: Execute the Demo Prompt**
    * Set the user prompt: *"I'm going camping in the Rockies and need a highly durable, waterproof tent. Can you find a good match, verify you have at least 2 in stock, and estimate shipping to zip code 80202?"*
    * Run the agent.
    * **Tracing:** Configure the ADK output to clearly print the reasoning trace (the ReAct loop) so the audience sees:
        1. ADK deciding to call the remote `elastic_semantic_product_search` via MCP.
        2. ADK deciding to call the remote `elastic_check_inventory` via MCP based on the first result.
        3. ADK calling the local `tool_calculate_shipping`.
        4. The final, synthesized natural language response.

* **Cell 6: Architecture Wrap-up (Markdown)**
    * Conclude with a summary of why enterprises prefer this: **Separation of Concerns**. The AI developers maintain a clean, lightweight ADK codebase, while the data engineering team maintains the complex Elastic queries and security boundaries behind the MCP server. If the database schema changes, the ADK code requires zero updates.DK environment.
    * *Markdown note:* Explain the dual-index architecture. Emphasize that because product descriptions and customer reviews live in different indices, the AI *must* logically chain tools to research both what the product is and what people think of it.

* **Cell 2: Establish the MCP Client Connection**
    * Initialize the MCP Client pointing to the `ELASTIC_MCP_SERVER_URL`.
    * Fetch and print the available tools to prove ADK is dynamically discovering the catalog search and review lookup tools.

* **Cell 3: Assemble the ADK Lead Agent**
    * Instantiate the main Google ADK Agent using a Gemini model.
    * Equip the agent's tool registry with the remote Elastic MCP tools.

* **Cell 4: Execute the Tool Chaining Prompt**
    * Set the user prompt: *"Find me a few quiet mechanical keyboards for my office. Compare the top options, and then summarize what actual customer reviews say about whether the keys feel sticky or mushy."*
    * Run the agent with tracing/verbose logging enabled.
    * **Expected Output Trace:** The notebook output must clearly show the iterative ReAct loop:
        1.  **Thought/Action:** ADK calls `elastic_semantic_product_search` to query the `product-catalog` and retrieves the `product_id` for 3 different keyboards.
        2.  **Thought/Action (Iteration):** ADK realizes it needs review feedback for comparison, so it calls `elastic_get_product_reviews` multiple times (once for each keyboard ID) to pull from the `customer-reviews` index.
        3.  **Observation/Generation:** ADK formulates a final, comparative response synthesizing the product features and the specific review feedback about key feel.

* **Cell 5: Architecture Wrap-up (Markdown)**
    * Conclude by summarizing the value: This proves you can build complex, research-driven AI workflows without writing messy Python database joins in the orchestration layer. By exposing purpose-built tools via MCP, Google ADK can navigate enterprise data silos, handle subset comparisons, and execute multi-step research loops just like a human would.