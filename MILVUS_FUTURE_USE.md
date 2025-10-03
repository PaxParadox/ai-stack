# Adding Milvus Vector Database (Future Use)

## What is Milvus?

Milvus is a high-performance vector database designed for storing and searching embeddings at scale. It's useful for:
- Building large-scale RAG (Retrieval Augmented Generation) systems
- Semantic search across millions of documents
- Recommendation systems
- Image/audio similarity search

## When You Might Need Milvus

Consider adding Milvus when you need to:
- Store more than 100,000 document embeddings
- Build production-scale semantic search
- Create custom RAG pipelines beyond Open WebUI's built-in capabilities
- Implement recommendation engines
- Process and search multimedia embeddings

## Current Alternative: Open WebUI's Built-in RAG

For now, you can use Open WebUI's integrated RAG features:
1. Upload documents directly in the UI
2. Automatic chunking and embedding using Ollama
3. ChromaDB handles vector storage internally
4. No additional configuration needed

## How to Add Milvus Back

### Option 1: Use the prepared compose file
```bash
# Start Milvus services
docker compose -f docker-compose.milvus.yml up -d

# Or merge into main compose:
cat docker-compose.milvus.yml >> docker-compose.yml
# (then edit to combine properly)
```

### Option 2: Quick command
```bash
# Copy Milvus services back to main compose
cp docker-compose.yml.backup docker-compose.yml

# Start Milvus
docker compose up -d milvus-etcd milvus-minio milvus-standalone
```

## Adding Attu Web GUI (Optional)

To add a web interface for Milvus:

```yaml
attu:
  image: zilliz/attu:v2.4
  container_name: attu
  restart: unless-stopped
  ports:
    - "8000:3000"
  environment:
    - MILVUS_URL=milvus-standalone:19530
  depends_on:
    - milvus-standalone
  networks:
    - ai-network
```

Then access at: http://ai-stack:8000

## Using Milvus

### Python Example
```python
from pymilvus import connections, Collection
import numpy as np

# Connect
connections.connect(host='ai-stack', port='19530')

# Create collection
from pymilvus import CollectionSchema, FieldSchema, DataType

fields = [
    FieldSchema(name="id", dtype=DataType.INT64, is_primary=True),
    FieldSchema(name="embedding", dtype=DataType.FLOAT_VECTOR, dim=384),
    FieldSchema(name="text", dtype=DataType.VARCHAR, max_length=65535)
]
schema = CollectionSchema(fields)
collection = Collection("documents", schema)

# Insert embeddings (get from Ollama)
# ... your code here
```

### With n8n Workflows
Create HTTP Request nodes to:
1. Get embeddings from Ollama
2. Store in Milvus via API
3. Search for similar vectors

## Resources

- [Milvus Documentation](https://milvus.io/docs)
- [Attu GUI Guide](https://github.com/zilliz/attu)
- [PyMilvus Examples](https://github.com/milvus-io/pymilvus)

## Note

Milvus requires significant resources for production use:
- ~200MB RAM minimum
- More RAM for larger datasets
- SSD storage recommended for performance

For simple RAG use cases, stick with Open WebUI's built-in features.
