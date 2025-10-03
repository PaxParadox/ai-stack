# 🎨 Image Generation Setup Guide

## What's Included

This setup adds two powerful image generation tools to your AI stack:

1. **ComfyUI** - Advanced node-based workflow for Stable Diffusion
2. **Stable Diffusion WebUI (Automatic1111)** - User-friendly interface

Both services use your **GTX 1050 Ti** (GPU 1) to keep Ollama running smoothly on the RTX 3090.

---

## 🚀 Quick Start

### Start the Services

```bash
cd /root/ai-stack
docker compose -f docker-compose.comfyui.yml up -d
```

### Check Status

```bash
docker ps | grep -E "comfyui|sd-webui"
docker logs comfyui -f
docker logs sd-webui -f
```

### Access the Interfaces

- **ComfyUI**: http://100.119.32.64:7860 or http://ai-stack:7860
- **SD-WebUI**: http://100.119.32.64:7861 or http://ai-stack:7861

---

## 📥 First-Time Setup

### 1. Wait for Initial Download

The first time you start these services, they will download:
- Base Stable Diffusion models (~4-8 GB)
- VAE models
- ControlNet models (optional)

**This can take 30-60 minutes depending on your internet speed.**

Watch the logs:
```bash
docker logs comfyui -f
# or
docker logs sd-webui -f
```

### 2. Download Models

Both services share models from: `/root/ai-stack/comfyui/models/`

#### For Stable Diffusion WebUI (Easier):
1. Open http://ai-stack:7861
2. Wait for the interface to load
3. Models will auto-download on first use
4. Or manually download:
   - Go to the "Models" tab
   - Click "Download" for your desired checkpoint

#### Recommended Models:
```bash
# Create models directory structure
mkdir -p /root/ai-stack/comfyui/models/{Stable-diffusion,VAE,Lora,ControlNet}

# Download Stable Diffusion 1.5 (Good for GTX 1050 Ti)
cd /root/ai-stack/comfyui/models/Stable-diffusion
wget https://huggingface.co/runwayml/stable-diffusion-v1-5/resolve/main/v1-5-pruned-emaonly.safetensors

# Download SDXL (More VRAM intensive, might be slow on 1050 Ti)
# wget https://huggingface.co/stabilityai/stable-diffusion-xl-base-1.0/resolve/main/sd_xl_base_1.0.safetensors

# Download VAE (improves colors)
cd /root/ai-stack/comfyui/models/VAE
wget https://huggingface.co/stabilityai/sd-vae-ft-mse-original/resolve/main/vae-ft-mse-840000-ema-pruned.safetensors
```

---

## 🎨 Using Stable Diffusion WebUI (Recommended for Beginners)

### Basic Image Generation

1. Open http://ai-stack:7861
2. Wait for interface to load
3. Enter your prompt: e.g., "a beautiful sunset over mountains, photorealistic, 4k"
4. Set parameters:
   - **Sampling method**: DPM++ 2M Karras
   - **Sampling steps**: 20-30
   - **Width/Height**: 512x512 (1050 Ti safe) or 768x768
   - **CFG Scale**: 7-9
5. Click "Generate"

### Tips for GTX 1050 Ti (4GB VRAM):
- Stick to 512x512 or 768x768 resolution
- Use 20-25 steps (not 50+)
- If you get "Out of Memory", reduce resolution
- Enable `--medvram` flag if needed (edit docker-compose)

### Advanced Features:
- **img2img**: Upload an image and transform it
- **Inpainting**: Edit specific parts of images
- **ControlNet**: Pose/depth/canny edge control
- **LoRA**: Style fine-tuning

---

## 🔧 Using ComfyUI (Advanced Users)

### What is ComfyUI?

Node-based interface where you build generation pipelines visually.

### Getting Started

1. Open http://ai-stack:7860
2. Load a default workflow (File → Load)
3. Drag and connect nodes
4. Common nodes:
   - **Load Checkpoint**: Select your model
   - **CLIP Text Encode**: Your prompt
   - **KSampler**: Generation settings
   - **Save Image**: Output

### Load Example Workflows

```bash
# Install community workflows
docker exec comfyui git clone https://github.com/comfyanonymous/ComfyUI_examples /workspace/workflows
```

Then in ComfyUI: File → Load → Select a workflow

---

## 🔌 API Usage

Both services have APIs for automation!

### Stable Diffusion WebUI API

```bash
# Generate an image via API
curl -X POST http://100.119.32.64:7861/sdapi/v1/txt2img \
  -H "Content-Type: application/json" \
  -d '{
    "prompt": "a cute cat, photorealistic",
    "negative_prompt": "blurry, low quality",
    "steps": 20,
    "width": 512,
    "height": 512,
    "cfg_scale": 7
  }'
```

### ComfyUI API

ComfyUI uses a workflow JSON format. See: http://ai-stack:7860/api/docs

---

## 🔗 Integration with n8n

Create an n8n workflow to automate image generation:

1. **Webhook** receives prompt
2. **HTTP Request** to SD-WebUI API
3. **Process response** and save image
4. **Return** image URL

Example workflow JSON coming soon!

---

## 🎯 Recommended Prompts to Test

```
1. "a majestic lion in the savanna, golden hour, photorealistic, 8k, highly detailed"

2. "cyberpunk city at night, neon lights, rain, cinematic, concept art"

3. "ancient library with magical books floating, fantasy art, detailed architecture"

4. "portrait of a warrior, detailed armor, dramatic lighting, digital art"

5. "peaceful zen garden, cherry blossoms, traditional japanese, watercolor style"
```

**Negative prompts to use:**
```
"blurry, low quality, distorted, deformed, ugly, bad anatomy, watermark, text"
```

---

## 🛠 Troubleshooting

### Service won't start
```bash
# Check logs
docker logs comfyui
docker logs sd-webui

# Restart
docker compose -f docker-compose.comfyui.yml restart
```

### "CUDA Out of Memory" error
**Solution 1**: Lower resolution (512x512 instead of 768x768)
**Solution 2**: Reduce batch size to 1
**Solution 3**: Add `--lowvram` flag:

Edit `docker-compose.comfyui.yml`:
```yaml
environment:
  - COMMANDLINE_ARGS=--listen --xformers --lowvram --api
```

### Slow generation
- GTX 1050 Ti is slower than RTX 3090
- Expected: 20-30 seconds per image at 512x512
- Use fewer sampling steps (20 instead of 50)

### Can't access from browser
```bash
# Check if service is running
docker ps | grep sd-webui

# Check port binding
netstat -tulpn | grep 7861

# Check Tailscale connection
ping ai-stack
```

### Model not found
```bash
# List available models
docker exec sd-webui ls -la /workspace/models/Stable-diffusion/

# Download model manually (see "Download Models" section above)
```

---

## 📊 Performance Expectations

### On GTX 1050 Ti (4GB VRAM):

| Resolution | Steps | Time per Image |
|------------|-------|----------------|
| 512x512 | 20 | ~20-30 seconds |
| 768x768 | 20 | ~45-60 seconds |
| 512x512 | 50 | ~60-90 seconds |

### Models that work well:
- ✅ Stable Diffusion 1.5
- ✅ SD 1.5 fine-tunes (realistic, anime, etc.)
- ⚠️ SDXL (slow, might require lowvram)
- ❌ SDXL Turbo (needs more VRAM)

---

## 🎨 Community Resources

- **Models**: https://civitai.com/
- **LoRAs**: https://civitai.com/models?types=LORA
- **Prompts**: https://lexica.art/
- **ComfyUI Workflows**: https://comfyworkflows.com/
- **SD WebUI Wiki**: https://github.com/AUTOMATIC1111/stable-diffusion-webui/wiki

---

## 🔄 Updating Services

```bash
# Pull latest images
docker compose -f docker-compose.comfyui.yml pull

# Restart with new images
docker compose -f docker-compose.comfyui.yml up -d
```

---

## 🗑 Cleanup / Removal

```bash
# Stop services
docker compose -f docker-compose.comfyui.yml down

# Remove data (WARNING: deletes models and generated images)
docker volume rm ai-stack_comfyui_data ai-stack_sd_webui_data
```

---

## 📝 Next Steps

1. ✅ Download Stable Diffusion 1.5 model
2. ✅ Test basic generation in SD-WebUI
3. ✅ Try different prompts and settings
4. ⬜ Download LoRAs for specific styles
5. ⬜ Create n8n workflow for automation
6. ⬜ Explore ComfyUI for advanced workflows

---

## 💡 Tips & Best Practices

1. **Start with SD-WebUI** - easier to learn
2. **Use negative prompts** - improves quality significantly
3. **512x512 is your friend** - faster, less VRAM
4. **Save good prompts** - build a prompt library
5. **Experiment with samplers** - DPM++ 2M Karras is fast and good
6. **Use CFG 7-9** - higher values follow prompt more strictly
7. **ControlNet is powerful** - for pose/composition control

---

## 🆘 Support

If you encounter issues:
1. Check logs: `docker logs sd-webui -f`
2. Verify GPU access: `docker exec sd-webui nvidia-smi`
3. Check GitHub issues for the respective projects
4. Reduce VRAM usage if OOM errors occur

---

**Happy Creating! 🎨**

*Remember: The GTX 1050 Ti is running these services. If you want faster generation, you could configure Ollama to use GPU 1 and move image generation to the RTX 3090, but that would impact LLM response times.*

