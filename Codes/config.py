import os
from dotenv import load_dotenv
load_dotenv()
# === PostgreSQL ===
POSTGRES_URI = "postgresql://postgres:Mihaxulo7@localhost:5432/climbing"

# === FAISS ===
FAISS_INDEX_PATH = "index/faiss_index"

# === OpenAI (RAG)
OPENAI_MODEL = "gpt-4.1"
OPENAI_TEMPERATURE = 0
OPENAI_API_KEY = os.getenv("OPENAI_API_KEY")

# === Split
CHUNK_SIZE = 500
CHUNK_OVERLAP = 50
