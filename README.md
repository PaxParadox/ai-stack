# Ultimate AI Stack

A comprehensive, locally-hosted AI infrastructure with multi-GPU support, RAG capabilities, and workflow automation.

## 🚀 Features

- **Multi-GPU Support**: RTX 3090 (24GB) for LLMs, GTX 1050 Ti (4GB) for embeddings
- **Complete AI Pipeline**: LLMs, embeddings, vector search, and RAG
- **Web Interfaces**: Open WebUI for chat, n8n for automation, MinIO console
- **Privacy-First**: SearXNG search, all data locally hosted
- **Tailscale Ready**: Secure remote access configured

## 📦 Services

| Service | Port | Purpose | GPU | URL |
|---------|------|---------|-----|-----|
| Open WebUI | 3000 | AI Chat Interface | - | http://ai-stack:3000 |
| Ollama | 11434 | LLM Inference | RTX 3090 | http://ai-stack:11434 |
| n8n | 5678 | Workflow Automation | - | http://ai-stack:5678 |
| SearXNG | 8888 | Private Search | - | http://ai-stack:8888 |
| TEI | 8090 | Text Embeddings | GTX 1050 Ti | http://ai-stack:8090 |
| Milvus | 19530 | Vector Database | - | http://ai-stack:19530 |
| MinIO | 9001 | Object Storage UI | - | http://ai-stack:9001 |
| PostgreSQL | 5432 | Database | - | Internal |
| Redis | 6379 | Cache | - | Internal |

## 🔧 Quick Start

```bash
# Clone the repository
git clone https://github.com/PaxParadox/ai-stack.git
cd ai-stack

# Start all services
docker compose up -d

# Check status
docker compose ps

# View logs
docker compose logs -f [service-name]
```

## 🎯 Usage Examples

### Chat with AI
1. Access Open WebUI at http://ai-stack:3000
2. Create an account (if first time)
3. Select a model and start chatting

### Pull AI Models
```bash
# Pull models to Ollama
docker exec ollama ollama pull llama3.2:3b
docker exec ollama ollama pull mixtral:8x7b
docker exec ollama ollama pull codellama:13b
```

### n8n Workflows
1. Access n8n at http://ai-stack:5678
2. Import workflows from `n8n/workflows/`
3. Available workflows:
   - AI RAG Pipeline
   - AI Search Assistant

### Search Configuration
SearXNG is configured for JSON output and integrated with Open WebUI.
Access directly at http://ai-stack:8888 for standalone search.

## 🔐 Security

- All services run in isolated Docker containers
- PostgreSQL and Redis are not exposed externally
- Tailscale provides secure remote access
- Default credentials in `.env` file (change in production!)

## 🛠 Configuration

Edit `.env` file to customize:
- Database passwords
- Service ports
- Model selections
- Authentication settings

## 📊 Resource Usage

- **RTX 3090 (24GB)**: Primary LLM inference
- **GTX 1050 Ti (4GB)**: Embeddings generation
- **RAM**: Recommended 32GB+
- **Storage**: 100GB+ for models and data

## 🔄 Maintenance

```bash
# Update services
docker compose pull
docker compose up -d

# Backup data
./scripts/backup.sh

# Clean up
docker compose down
docker system prune -a
```

## 📚 API Endpoints

- **Ollama API**: `http://ai-stack:11434/api/generate`
- **TEI Embeddings**: `http://ai-stack:8090/embed`
- **Milvus API**: `http://ai-stack:19530`
- **n8n Webhooks**: `http://ai-stack:5678/webhook/*`

## 🤝 Contributing

Pull requests welcome! Please test changes locally before submitting.

## 📝 License

MIT License - See LICENSE file

## 🆘 Troubleshooting

If services fail to start:
1. Check GPU drivers: `nvidia-smi`
2. Verify Docker GPU support: `docker run --rm --gpus all nvidia/cuda:11.0-base nvidia-smi`
3. Check logs: `docker compose logs [service-name]`
4. Ensure sufficient resources (RAM, disk space)

## 🔗 Links

- [Open WebUI Documentation](https://docs.openwebui.com)
- [Ollama Models](https://ollama.ai/library)
- [n8n Documentation](https://docs.n8n.io)
- [Milvus Documentation](https://milvus.io/docs)
