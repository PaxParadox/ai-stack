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
| **Ollama** | http://100.119.32.64:11434 | `/api/generate`, `/api/chat` |
| **Milvus** | http://100.119.32.64:19530 | Vector database operations |

## First Time Setup

### 1. Open WebUI
1. Navigate to http://100.119.32.64:3000
2. Click "Sign Up" to create your admin account
3. Once logged in, models from Ollama will be automatically available
4. Test search by typing a query and selecting "Search Web"

### 2. n8n
1. Navigate to http://100.119.32.64:5678
2. Create your owner account
3. Import example workflows from `/root/ai-stack/n8n/workflows/`
4. Available workflows:
   - `ai-rag-pipeline.json` - RAG pipeline with embeddings
   - `ai-search-assistant.json` - Web search with AI responses

### 3. Pull Additional Models
```bash
# Connect to the server and run:
docker exec ollama ollama pull mistral
docker exec ollama ollama pull codellama:13b
docker exec ollama ollama pull llama3.2:7b
```

## Testing Services

Run the health check script:
```bash
cd /root/ai-stack
./check_services.sh
```

## Troubleshooting

### Service not accessible?
1. Check if container is running: `docker ps`
2. Check logs: `docker logs <container-name>`
3. Restart service: `docker compose restart <service-name>`

### n8n shows secure cookie warning?
Already fixed - N8N_SECURE_COOKIE is set to false

### Ollama not using GPU?
Check GPU status: `nvidia-smi`
Verify in container: `docker exec ollama nvidia-smi`

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
