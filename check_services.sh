#!/bin/bash
echo "=== AI Stack Service Status ==="
echo
echo "Service Health Check:"
echo "--------------------"

# Check Open WebUI
if curl -s -o /dev/null -w "%{http_code}" http://localhost:3000 | grep -q "200\|302"; then
    echo "✅ Open WebUI: http://100.119.32.64:3000"
    echo "   └─ Built-in RAG with ChromaDB"
else
    echo "❌ Open WebUI"
fi

# Check Ollama
if curl -s http://localhost:11434/api/version > /dev/null; then
    echo "✅ Ollama API: http://100.119.32.64:11434"
    echo "   └─ Embeddings: via nomic-embed-text model"
else
    echo "❌ Ollama API"
fi

# Check n8n
if curl -s -o /dev/null -w "%{http_code}" http://localhost:5678 | grep -q "200\|302"; then
    echo "✅ n8n: http://100.119.32.64:5678"
else
    echo "❌ n8n"
fi

# Check SearXNG
if curl -s -o /dev/null -w "%{http_code}" http://localhost:8888 | grep -q "200"; then
    echo "✅ SearXNG: http://100.119.32.64:8888"
else
    echo "❌ SearXNG"
fi

echo
echo "Available Models:"
echo "----------------"
docker exec ollama ollama list 2>/dev/null || echo "Unable to list models"

echo
echo "Container Status:"
echo "----------------"
docker ps --format "table {{.Names}}\t{{.Status}}" | column -t

echo
echo "GPU Usage:"
echo "----------"
nvidia-smi --query-gpu=index,name,utilization.gpu,memory.used,memory.total --format=csv,noheader,nounits | column -t -s ','

echo
echo "💡 Tip: For vector database needs, use Open WebUI's built-in RAG"
echo "   or see MILVUS_FUTURE_USE.md to add Milvus later"
