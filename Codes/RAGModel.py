from langchain.embeddings import OpenAIEmbeddings
from langchain.vectorstores import FAISS
from langchain.schema import Document
from Codes.config import FAISS_INDEX_PATH, OPENAI_API_KEY
from dotenv import load_dotenv
load_dotenv()  # Charge le fichier .env
import os

OPENAI_API_KEY = os.getenv("OPENAI_API_KEY")

def build_faiss_index(chunks):
    """
    Construit un index FAISS à partir de textes.
    """
    docs = [Document(page_content=chunk) for chunk in chunks]
    index = FAISS.from_documents(docs, OpenAIEmbeddings())
    index.save_local(FAISS_INDEX_PATH)
    return index