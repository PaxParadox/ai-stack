# How to Import Workflows into n8n

## Available Workflows

1. **ollama-chat-workflow.json** - Simple chat API with Ollama
2. **searxng-ai-search.json** - Web search with AI-powered answers
3. **ai-rag-pipeline.json** - RAG pipeline with embeddings (requires Milvus setup)
4. **ai-search-assistant.json** - Basic search assistant

## Import Instructions

### Method 1: Through n8n UI (Recommended)

1. Open n8n at http://100.119.32.64:5678
2. Click on the menu (☰) in the top left
3. Select "Workflows" → "Import from File"
4. Click "Select File" and browse to one of these files:
   - `/root/ai-stack/n8n/workflows/ollama-chat-workflow.json`
   - `/root/ai-stack/n8n/workflows/searxng-ai-search.json`
5. Click "Import"
6. The workflow will appear in your editor
7. Click "Save" to keep it

### Method 2: Copy & Paste JSON

1. Open n8n at http://100.119.32.64:5678
2. Create a new workflow (+ button)
3. Press Ctrl+A to select all (the default node)
4. Press Delete to clear the canvas
5. Press Ctrl+V to open the paste dialog
6. Copy the content of a workflow file:
   ```bash
   cat /root/ai-stack/n8n/workflows/ollama-chat-workflow.json
   ```
7. Paste the JSON into n8n
8. Click "Save"

### Method 3: Direct Import via Terminal

```bash
# Copy workflow content to clipboard (if you have clipboard access)
cat /root/ai-stack/n8n/workflows/ollama-chat-workflow.json | xclip -selection clipboard

# Or display for manual copying
cat /root/ai-stack/n8n/workflows/ollama-chat-workflow.json
```

## Testing the Workflows

### Test Ollama Chat Workflow
1. After importing, click "Execute Workflow"
2. Click on the Webhook node
3. You'll see a test URL like: `http://100.119.32.64:5678/webhook-test/chat`
4. Test it with curl:
   ```bash
   curl -X POST http://100.119.32.64:5678/webhook-test/chat \
     -H "Content-Type: application/json" \
     -d '{"model": "llama3.2:3b", "messages": [{"role": "user", "content": "Hello!"}]}'
   ```

### Test Search Assistant Workflow
1. After importing, activate the workflow
2. Get the webhook URL from the Webhook node
3. Test it:
   ```bash
   curl -X POST http://100.119.32.64:5678/webhook-test/search \
     -H "Content-Type: application/json" \
     -d '{"query": "What is Docker?"}'
   ```

## Activating Workflows

1. After testing, click the toggle switch in the top right to "Active"
2. The webhook URLs will change from `/webhook-test/` to `/webhook/`
3. Save the workflow

## Troubleshooting

- **Workflow doesn't appear?** Make sure you clicked "Save" after importing
- **Webhook not working?** Check if the workflow is activated (toggle switch)
- **Connection errors?** Verify services are running: `docker ps`
- **Ollama not responding?** Check if model is loaded: `docker exec ollama ollama list`
