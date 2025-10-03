#!/bin/bash

echo "==================================="
echo "   n8n Workflow Import Helper"
echo "==================================="
echo

# List available workflows
echo "Available workflows:"
echo "1) Ollama Chat API - Simple chat endpoint"
echo "2) AI Web Search - Search with AI-powered answers"
echo "3) RAG Pipeline - Document embeddings (advanced)"
echo "4) Search Assistant - Basic search integration"
echo

read -p "Select workflow to display (1-4): " choice

case $choice in
    1)
        workflow="ollama-chat-workflow.json"
        name="Ollama Chat API"
        ;;
    2)
        workflow="searxng-ai-search.json"
        name="AI Web Search"
        ;;
    3)
        workflow="ai-rag-pipeline.json"
        name="RAG Pipeline"
        ;;
    4)
        workflow="ai-search-assistant.json"
        name="Search Assistant"
        ;;
    *)
        echo "Invalid choice"
        exit 1
        ;;
esac

echo
echo "Selected: $name"
echo
echo "IMPORT INSTRUCTIONS:"
echo "==================="
echo "1. Copy ALL the JSON text below (starting with { and ending with })"
echo "2. Open n8n in your browser: http://100.119.32.64:5678"
echo "3. Login or create your account"
echo "4. In n8n, press Ctrl+Shift+V (or Cmd+Shift+V on Mac)"
echo "5. Paste the JSON and click 'Import'"
echo "6. Save the workflow"
echo
echo "Press Enter to display the workflow JSON..."
read

echo
echo "=== COPY EVERYTHING BELOW THIS LINE ==="
echo
cat "n8n/workflows/$workflow"
echo
echo "=== COPY EVERYTHING ABOVE THIS LINE ==="
echo
echo "After copying:"
echo "1. Go to n8n (http://100.119.32.64:5678)"
echo "2. Press Ctrl+Shift+V to import"
echo "3. Paste and click Import"
