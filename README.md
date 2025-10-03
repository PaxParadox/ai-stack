# Ultimate AI Stack

A comprehensive, locally-hosted AI infrastructure with multi-GPU support and workflow automation.

## 🚀 Features

- **Multi-GPU Support**: RTX 3090 (24GB) + GTX 1050 Ti (4GB)
- **Complete AI Pipeline**: LLMs, embeddings (via Ollama), and RAG capabilities
- **Image Generation**: Stable Diffusion via ComfyUI and Automatic1111 WebUI
- **Web Interfaces**: Open WebUI for chat, n8n for automation
- **Privacy-First**: SearXNG search, all data locally hosted
- **Tailscale Ready**: Secure remote access configured

## 📦 Active Services

| Service | Port | Purpose | GPU | URL |
|---------|------|---------|-----|-----|
| Open WebUI | 3000 | AI Chat Interface with built-in RAG | - | http://ai-stack:3000 |
| Ollama | 11434 | LLM Inference & Embeddings | RTX 3090 | http://ai-stack:11434 |
| **ComfyUI** | **7860** | **Advanced Image Generation (Node-based)** | **GTX 1050 Ti** | **http://ai-stack:7860** |
| **SD-WebUI** | **7861** | **Stable Diffusion (User-friendly)** | **GTX 1050 Ti** | **http://ai-stack:7861** |
| n8n | 5678 | Workflow Automation | - | http://ai-stack:5678 |
| SearXNG | 8888 | Private Search | - | http://ai-stack:8888 |
| PostgreSQL | 5432 | Database | - | Internal |
| Redis | 6379 | Cache | - | Internal |

## 🔧 Quick Start

```bash
# Clone the repository
git clone https://github.com/PaxParadox/ai-stack.git
cd ai-stack

# Start all services
docker compose up -d

# Start image generation services (optional)
docker compose -f docker-compose.comfyui.yml up -d

# Check status
./check_services.sh

# View logs
docker compose logs -f [service-name]
```

## 🎯 Usage Examples

### Chat with AI
1. Access Open WebUI at http://ai-stack:3000
2. Create an account (if first time)
3. Select a model and start chatting
4. Web search is integrated - just ask questions!

### RAG (Document Search)
Open WebUI includes built-in RAG capabilities:
1. Upload documents directly in the UI
2. Automatic chunking and embedding using Ollama
3. ChromaDB handles vector storage internally
4. No additional configuration needed

### Available AI Models
```bash
# Currently installed
docker exec ollama ollama list

# Pull additional models
docker exec ollama ollama pull llama3.2:7b
docker exec ollama ollama pull mixtral:8x7b
docker exec ollama ollama pull codellama:13b
```

### Embeddings
Using Ollama's `nomic-embed-text` model for embeddings (already installed)

### n8n Workflows
1. Access n8n at http://ai-stack:5678
2. Import workflows from `n8n/workflows/`:
   - `ollama-chat-workflow.json` - Chat API endpoint
   - `searxng-ai-search.json` - AI-powered web search
   
Run the import helper:
```bash
./import_workflow.sh
```

### Search Configuration
SearXNG is configured for JSON output and integrated with Open WebUI.
Access directly at http://ai-stack:8888 for standalone search.

### Image Generation 🎨
Generate images using Stable Diffusion:

**Stable Diffusion WebUI** (Recommended for beginners):
1. Access at http://ai-stack:7861
2. Enter your prompt: e.g., "a beautiful sunset over mountains, photorealistic, 4k"
3. Click "Generate" and wait ~30 seconds
4. Features: txt2img, img2img, inpainting, ControlNet

**ComfyUI** (Advanced workflows):
1. Access at http://ai-stack:7860
2. Node-based interface for complex generation pipelines
3. Load example workflows and customize

See `IMAGE_GENERATION_GUIDE.md` for detailed instructions, tips, and API usage.

## 🔐 Security & Access

- All services accessible via Tailscale at `100.119.32.64` or `ai-stack`
- PostgreSQL and Redis are not exposed externally
- Default credentials in `.env` file (change in production!)
- N8N_SECURE_COOKIE disabled for HTTP access via Tailscale

## 🛠 Configuration

Edit `.env` file to customize:
- Database passwords
- Service ports
- Model selections

## 📊 Resource Usage

- **RTX 3090 (24GB)**: Primary LLM inference and embeddings (Ollama)
- **GTX 1050 Ti (4GB)**: Image generation (ComfyUI/SD-WebUI)
- **RAM**: Recommended 32GB+ (current: 5GB available)
- **Storage**: 100GB+ for models and data (current: 499GB free)

## 🔄 Maintenance

```bash
# Update services
docker compose pull
docker compose up -d

# Check service health
./check_services.sh

# Clean up
docker compose down
docker system prune -a
```

## 📚 API Endpoints

- **Ollama API**: `http://ai-stack:11434/api/generate`
- **Ollama Chat**: `http://ai-stack:11434/api/chat`
- **Ollama Embeddings**: `http://ai-stack:11434/api/embeddings`
- **SD-WebUI API**: `http://ai-stack:7861/sdapi/v1/txt2img`
- **n8n Webhooks**: `http://ai-stack:5678/webhook/*`

## 🚀 Optional Add-ons

See `NEXT_STEPS.md` and `UPGRADE_PLAN.md` for additional services:
- ✅ ComfyUI & SD-WebUI for image generation (Already added!)
- Whisper for speech-to-text
- Monitoring with Grafana + Prometheus
- Voice synthesis with TTS
- And more!

For advanced vector database needs, see `MILVUS_FUTURE_USE.md`

## 🤝 Contributing

Pull requests welcome! Please test changes locally before submitting.

## 📝 License

MIT License - See LICENSE file

## 🆘 Troubleshooting

### Service Issues
```bash
# Check status
docker ps
./check_services.sh

# View logs
docker logs [container-name]

# Restart service
docker compose restart [service-name]
```

### GPU Issues
```bash
# Check GPU status
nvidia-smi

# Verify in container
docker exec ollama nvidia-smi
```

### n8n Secure Cookie Warning
Already fixed - N8N_SECURE_COOKIE=false is set

## 🔗 Documentation

- [Open WebUI Documentation](https://docs.openwebui.com)
- [Ollama Documentation](https://github.com/ollama/ollama)
- [ComfyUI Documentation](https://github.com/comfyanonymous/ComfyUI)
- [Stable Diffusion WebUI Wiki](https://github.com/AUTOMATIC1111/stable-diffusion-webui/wiki)
- [n8n Documentation](https://docs.n8n.io)
- [SearXNG Documentation](https://docs.searxng.org)

## 📖 Local Guides

- `ACCESS_GUIDE.md` - Service URLs and first-time setup
- `IMAGE_GENERATION_GUIDE.md` - Complete image generation tutorial
- `UPGRADE_PLAN.md` - Future upgrade options
- `NEXT_STEPS.md` - Quick add-on suggestions
