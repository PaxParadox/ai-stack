# 📋 Step-by-Step: How to Import Workflows into n8n

## Method 1: Using the Import Helper Script (EASIEST)

```bash
cd /root/ai-stack
./import_workflow.sh
```

This will:
1. Show you available workflows
2. Display the JSON for copying
3. Give you import instructions

## Method 2: Manual Import (Step by Step)

### Step 1: Access n8n
Open your browser and go to:
```
http://100.119.32.64:5678
```
Or if using Tailscale hostname:
```
http://ai-stack:5678
```

### Step 2: Login/Create Account
- If first time: Click "Create an account"
- Fill in your details
- Otherwise: Login with your credentials

### Step 3: Import the Workflow

#### Option A: Keyboard Shortcut (Fastest)
1. Once logged in, press **Ctrl+Shift+V** (Windows/Linux) or **Cmd+Shift+V** (Mac)
2. A dialog box will appear saying "Import Workflow"
3. Delete any existing content in the box
4. Paste the workflow JSON (see below for how to get it)
5. Click "Import"

#### Option B: Via Menu
1. Click the hamburger menu (☰) in top-left corner
2. Go to "Workflows" → "Import from File" or "Import from URL"
3. If "Import from File": Browse to `/root/ai-stack/n8n/workflows/` and select a file
4. Click "Import"

#### Option C: Copy-Paste in Editor
1. Create a new workflow (click + button)
2. Select all nodes (Ctrl+A) and delete them
3. Press Ctrl+V
4. Paste the workflow JSON
5. Click outside the paste area

### Step 4: Get the Workflow JSON

Run this command to display a workflow:

```bash
# For Ollama Chat workflow
cat /root/ai-stack/n8n/workflows/ollama-chat-workflow.json

# For AI Search workflow  
cat /root/ai-stack/n8n/workflows/searxng-ai-search.json
```

### Step 5: Save and Test

1. After importing, click "Save" button (top right)
2. Give your workflow a name if prompted
3. To test:
   - Click "Execute Workflow" button
   - Check the output of each node
   - Fix any errors if they appear

### Step 6: Activate the Workflow

1. Toggle the "Active" switch in top-right (changes from Inactive to Active)
2. For webhook-based workflows, note the webhook URL
3. Save again

## 🚀 Quick Copy Commands

Get workflow JSON for copying:

```bash
# Simple Ollama Chat API
echo "=== COPY BELOW ===" && cat /root/ai-stack/n8n/workflows/ollama-chat-workflow.json && echo "=== END ==="

# AI-Powered Web Search
echo "=== COPY BELOW ===" && cat /root/ai-stack/n8n/workflows/searxng-ai-search.json && echo "=== END ==="
```

## 📝 Testing Your Imported Workflows

### Test Ollama Chat:
```bash
curl -X POST http://100.119.32.64:5678/webhook-test/chat \
  -H "Content-Type: application/json" \
  -d '{
    "model": "llama3.2:3b",
    "messages": [
      {"role": "user", "content": "Hello, how are you?"}
    ]
  }'
```

### Test AI Search:
```bash
curl -X POST http://100.119.32.64:5678/webhook-test/search \
  -H "Content-Type: application/json" \
  -d '{"query": "What is Docker?"}'
```

## ❓ Troubleshooting

### "Cannot import workflow"
- Make sure you copied the ENTIRE JSON (from { to })
- Check that you're not including any extra text before or after

### "Workflow not found after import"
- Did you click "Save"?
- Check "All Workflows" in the menu

### "Webhook returns 404"
- Is the workflow activated? (toggle switch should be ON)
- Did you use the correct URL? Test URLs have `/webhook-test/`, production URLs have `/webhook/`

### "Connection refused to Ollama/SearXNG"
- Check services are running: `docker ps`
- Internal Docker networking uses service names (ollama, searxng), not IPs

## 🎯 Recommended First Workflow

Start with the **Ollama Chat API** workflow:
1. It's the simplest
2. Tests your Ollama connection
3. Easy to verify it works

Then try the **AI Web Search** workflow for more complex automation.
