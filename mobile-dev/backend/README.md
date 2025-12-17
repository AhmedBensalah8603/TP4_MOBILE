# Avatar Backend Stub

Minimal FastAPI service to prototype the Avatar LLM + TTS backend used by the Flutter app.

Features:
- POST /avatar/message — accepts { text } and returns { replyText, ttsUrl? }
- Optional Azure TTS integration (requires AZURE_TTS_KEY and AZURE_TTS_REGION env vars)
- Simple file-based static serving for generated audio (for local dev)

Quick start (local):

1. Copy `.env.example` to `.env` and set values. For local testing you can skip Azure keys to get text-only responses.
2. Install & run locally:
   python -m venv .venv
   .venv\Scripts\activate (Windows) or source .venv/bin/activate
   pip install -r requirements.txt
   uvicorn main:app --reload --host 0.0.0.0 --port 8000

3. Example request:
   curl -X POST 'http://localhost:8000/avatar/message' -H 'Content-Type: application/json' -d "{\"text\":\"Hello world\"}"

Production: build the Docker image and deploy to Azure Container Instances / App Service / Container Apps.

Azure deployment (example)

1. Build and push to Azure Container Registry (ACR):

   ```bash
   # Build
   docker build -t myregistry.azurecr.io/aquora-avatar:latest .

   # Login to ACR
   az acr login --name myregistry

   # Push
   docker push myregistry.azurecr.io/aquora-avatar:latest
   ```

2. Create a container instance (example):

   ```bash
   az container create \
     --resource-group my-rg \
     --name aquora-avatar \
     --image myregistry.azurecr.io/aquora-avatar:latest \
     --ports 8000 \
     --environment-variables PUBLIC_BASE_URL=https://your-host.example AZURE_TTS_KEY="<key>" AZURE_TTS_REGION="<region>" AZURE_OPENAI_ENDPOINT="https://<resource>.openai.azure.com" AZURE_OPENAI_KEY="<key>" AZURE_OPENAI_DEPLOYMENT="<deployment>" \
     --cpu 1 --memory 1.5
   ```

3. For production secrets, prefer Azure Key Vault or Container Apps managed identity and environment variable injection instead of inlining keys.

Azure OpenAI notes:
- Create a deployment in your Azure OpenAI resource (choose a model and create a deployment name).
- Set `AZURE_OPENAI_ENDPOINT`, `AZURE_OPENAI_KEY`, and `AZURE_OPENAI_DEPLOYMENT` in your production environment (use Azure Key Vault or Container App environment settings).
- The stub calls the Azure OpenAI Chat Completions endpoint; responses are returned as `replyText`.

Security: this stub expects keys via environment variables. Do not commit production secrets to the repo. Use Azure Key Vault or container-managed identities in production.
