# AI Stack Access Guide

## Service URLs

All services are accessible via Tailscale at IP: **100.119.32.64** or hostname: **ai-stack**

### Web Interfaces

| Service | URL | Credentials | Purpose |
|---------|-----|-------------|---------|
| **Open WebUI** | http://100.119.32.64:3000 | Create on first login | AI Chat Interface |
| **n8n** | http://100.119.32.64:5678 | Create on first login | Workflow Automation |
| **SearXNG** | http://100.119.32.64:8888 | No login required | Private Search Engine |
| **MinIO Console** | http://100.119.32.64:9001 | minioadmin / minioadmin123 | Object Storage |

### API Endpoints

| Service | Endpoint | Example |
|---------|----------|---------|
| **Ollama** | http://100.119.32.64:11434 | `/api/generate`, `/api/chat`, `/api/embeddings` |
| **Milvus** | http://100.119.32.64:19530 | Vector database operations |
| **n8n Webhooks** | http://100.119.32.64:5678/webhook/* | Custom automation endpoints |

## Currently Installed Models

- **llama3.2:3b** - Fast conversational AI (2.0 GB)
- **nomic-embed-text** - Text embeddings for RAG (274 MB)

## First Time Setup

### 1. Open WebUI
1. Navigate to http://100.119.32.64:3000
2. Click "Sign Up" to create your admin account
3. Once logged in, models from Ollama will be automatically available
4. Test search by typing a query and using the search feature

### 2. n8n
1. Navigate to http://100.119.32.64:5678
2. Create your owner account
3. Import workflows using the helper script:
   ```bash
   cd /root/ai-stack
   ./import_workflow.sh
   ```
4. Available workflows:
   - `ollama-chat-workflow.json` - Chat API endpoint
   - `searxng-ai-search.json` - AI-powered web search

### 3. Pull Additional Models
```bash
# Connect to the server and run:
docker exec ollama ollama pull mistral
docker exec ollama ollama pull codellama:13b
docker exec ollama ollama pull llama3.2:7b

# For better embeddings (optional)
docker exec ollama ollama pull mxbai-embed-large
```

## Testing Services

Run the health check script:
```bash
cd /root/ai-stack
./check_services.sh
```

## Using Embeddings

Ollama provides embeddings via the `nomic-embed-text` model:

```bash
# Example: Generate embeddings
curl http://100.119.32.64:11434/api/embeddings \
  -d '{"model": "nomic-embed-text", "prompt": "Hello world"}'
```

## Troubleshooting

### Service not accessible?
1. Check if container is running: `docker ps`
2. Check logs: `docker logs <container-name>`
3. Restart service: `docker compose restart <service-name>`

### Ollama not using GPU?
```bash
# Check GPU status
nvidia-smi

# Verify in container
docker exec ollama nvidia-smi
```

### Need to reset a service?
```bash
docker compose down <service-name>
docker volume rm ai-stack_<service>_data  # Careful: deletes data!
docker compose up -d <service-name>
```

## Security Notes

1. **Change default passwords** in production:
   - Edit `.env` file
   - Update MinIO credentials
   - Set strong PostgreSQL password

2. **Tailscale Security**:
   - Services are only accessible within your Tailscale network
   - No ports are exposed to the public internet
   - All traffic is encrypted by Tailscale

3. **Data Storage**:
   - All data is stored in Docker volumes
   - Located at `/var/lib/docker/volumes/ai-stack_*`
   - Regular backups recommended

## Resource Monitoring

Check GPU usage:
```bash
nvidia-smi -l 1  # Updates every second
```

Check container resources:
```bash
docker stats
```

Check disk usage:
```bash
df -h
docker system df
```

## Quick Commands

```bash
# View all running services
docker ps

# Check logs for a service
docker logs -f <service-name>

# Restart all services
docker compose restart

# Stop all services
docker compose stop

# Start all services
docker compose start
```
