#!/bin/bash
echo "=== AI Stack Service Status ==="
echo
echo "Service Health Check:"
echo "--------------------"

# Check Open WebUI
if curl -s -o /dev/null -w "%{http_code}" http://localhost:3000 | grep -q "200\|302"; then
    echo "✅ Open WebUI: http://100.119.32.64:3000"
else
    echo "❌ Open WebUI"
fi

# Check Ollama
if curl -s http://localhost:11434/api/version > /dev/null; then
    echo "✅ Ollama API: http://100.119.32.64:11434"
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

# Check MinIO Console
if curl -s -o /dev/null -w "%{http_code}" http://localhost:9001 | grep -q "200\|403"; then
    echo "✅ MinIO Console: http://100.119.32.64:9001"
else
    echo "❌ MinIO Console"
fi

echo
echo "Available Models:"
echo "----------------"
docker exec ollama ollama list 2>/dev/null || echo "Unable to list models"

echo
echo "Container Status:"
echo "----------------"
docker ps --format "table {{.Names}}\t{{.Status}}" | column -t
