# 🎨 Image Generation in Open WebUI

## ✅ Integration Complete!

Your Open WebUI is now configured to generate images using Stable Diffusion!

---

## 🚀 How to Generate Images in Open WebUI

### Method 1: Use the `/imagine` Command

In any chat, simply type:

```
/imagine a beautiful sunset over mountains, photorealistic, 4k
```

Press Enter and Open WebUI will:
1. Send the prompt to Stable Diffusion
2. Generate the image (takes 15-30 seconds)
3. Display it directly in the chat

### Method 2: Use the Image Generation Icon

1. Open any chat in Open WebUI
2. Look for the **image icon** (🖼️) in the message input area
3. Click it to open the image generation dialog
4. Enter your prompt
5. Adjust settings if needed (size, steps)
6. Click "Generate"

---

## ⚙️ Default Settings

Your configuration:
- **Engine**: Stable Diffusion (Automatic1111)
- **Default Size**: 512x512 (fast, good quality)
- **Steps**: 30 (good balance)
- **GPU**: RTX 3090 (shared with Ollama)

---

## 🎨 Tips for Better Images

### Good Prompts:
```
/imagine cyberpunk city at night, neon lights, rain, cinematic, highly detailed

/imagine portrait of a warrior, detailed armor, dramatic lighting, digital art, 8k

/imagine peaceful zen garden, cherry blossoms, japanese style, watercolor

/imagine cute robot reading a book, pixar style, colorful, 3d render
```

### Negative Prompts:
You can also add negative prompts (in Admin Settings → Image Generation):
```
blurry, low quality, distorted, deformed, ugly, bad anatomy, watermark
```

---

## 🔧 Advanced Configuration

### Change Image Size

Go to **Admin Panel** → **Settings** → **Image Generation**:

- **512x512**: Fast, good for most uses (default)
- **768x768**: Better quality, slower
- **1024x1024**: High quality (RTX 3090 can handle it!)

### Change Quality (Steps)

- **20 steps**: Fast (~10-15 seconds)
- **30 steps**: Balanced quality/speed (default)
- **50 steps**: Highest quality (~30-40 seconds)

### Alternative: Use Comfy UI

If you prefer ComfyUI:
1. Go to Admin Panel → Settings → Image Generation
2. Change `Engine` from `automatic1111` to `comfyui`
3. Update Base URL to: `http://comfyui:8188`

---

## 🔗 Integration with Chat

### Generate Images Based on Conversation

```
You: "Tell me about cyberpunk cities"
AI: [Explains cyberpunk aesthetics]
You: "/imagine cyberpunk city based on your description"
AI: [Generates image]
```

### Image-to-Image (Advanced)

1. Upload an image to chat
2. Type: `/imagine transform this into [style description]`
3. Open WebUI will use img2img mode

---

## 🎯 Common Use Cases

### 1. **Concept Art**
```
/imagine futuristic spaceship interior, sci-fi, detailed controls, blue lighting
```

### 2. **Character Design**
```
/imagine fantasy character, elven archer, detailed outfit, forest background
```

### 3. **Logo Ideas**
```
/imagine modern tech company logo, minimalist, blue and white, professional
```

### 4. **Product Visualization**
```
/imagine sleek wireless headphones, product photography, white background
```

### 5. **Scene Setting**
```
/imagine cozy coffee shop interior, warm lighting, afternoon, realistic
```

---

## 🐛 Troubleshooting

### Image Generation Fails

**Check if SD-WebUI is running:**
```bash
docker ps | grep sd-webui
docker logs sd-webui --tail 20
```

**Restart if needed:**
```bash
docker restart sd-webui
```

### Slow Generation

- Reduce image size (512x512)
- Lower steps (20-25)
- Check GPU usage: `nvidia-smi`

### "Out of Memory" Error

The RTX 3090 has 24GB, so this shouldn't happen. If it does:
1. Check if Ollama is using too much VRAM
2. Restart both services:
```bash
docker restart sd-webui open-webui
```

---

## 📊 Performance

With your **RTX 3090** setup:

| Size | Steps | Generation Time |
|------|-------|-----------------|
| 512x512 | 20 | ~10 seconds |
| 512x512 | 30 | ~15 seconds |
| 768x768 | 30 | ~20 seconds |
| 1024x1024 | 30 | ~25 seconds |
| 1024x1024 | 50 | ~40 seconds |

---

## 🔐 Admin Settings

Access at: **http://ai-stack:3000/admin/settings**

Navigate to **Image Generation** section:

- **Enable/Disable**: Toggle image generation
- **Engine**: automatic1111 or comfyui
- **Base URL**: Where SD-WebUI is running
- **Default Model**: Select from available models
- **Default Size**: Set preferred resolution
- **Steps**: Set quality level

---

## 🎨 Examples to Try Right Now

Copy and paste these into Open WebUI:

```
/imagine a majestic dragon flying over mountains, epic fantasy art, highly detailed, 8k

/imagine cute robot holding a flower, pixar style, colorful, 3d render, soft lighting

/imagine ancient library with floating books, magical atmosphere, warm lighting, fantasy art

/imagine modern minimalist living room, scandinavian design, natural light, professional photography

/imagine cyberpunk street market, neon signs, rain, night, cinematic, blade runner style
```

---

## 🚀 Pro Tips

1. **Be Specific**: More details = better results
   - ❌ "a house"
   - ✅ "modern house, large windows, mountain view, sunset lighting, architectural photography"

2. **Use Style Keywords**:
   - Photography: "photorealistic, 8k, professional photography"
   - Art: "digital art, concept art, artstation"
   - 3D: "3d render, octane render, unreal engine"
   - Painting: "oil painting, watercolor, impressionist"

3. **Add Quality Boosters**:
   - "highly detailed"
   - "intricate details"
   - "professional"
   - "award winning"

4. **Combine with AI Chat**:
   - Ask AI to suggest prompts
   - Refine images based on AI feedback
   - Create variations of generated images

---

## 🔄 Workflow Example

**Creative workflow:**

```
You: "I need ideas for a fantasy book cover"

AI: "Here are some concepts..."
     - Ancient wizard's tower
     - Dragon guardian
     - Mystical forest portal

You: "/imagine ancient wizard's tower on cliff edge, stormy sky, 
      lightning, fantasy art, detailed architecture, dramatic lighting"

AI: [Generates image]

You: "Make it darker and more ominous"

You: "/imagine [same prompt] dark atmosphere, ominous clouds, gothic style"

AI: [Generates variation]
```

---

## 📚 Additional Resources

- **Prompt Guide**: https://lexica.art/ (search for inspiration)
- **Style References**: https://civitai.com/ (see different art styles)
- **Open WebUI Docs**: https://docs.openwebui.com

---

## ✨ What's Next?

- Download additional models (SDXL, specialized models)
- Try ControlNet for pose/composition control
- Create LoRAs for specific styles
- Integrate with n8n workflows
- Set up img2img and inpainting

---

**Happy Creating! 🎨**

Your images are generated on your own hardware - completely private and unlimited!

