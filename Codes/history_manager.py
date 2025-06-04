import sqlite3
from datetime import datetime
import os

HISTORY_DB_PATH = "Data/chat_history.db"

def init_history_db(db_path=HISTORY_DB_PATH):
    os.makedirs(os.path.dirname(db_path), exist_ok=True)
    conn = sqlite3.connect(db_path)



    cursor = conn.cursor()
    cursor.execute("""
        CREATE TABLE IF NOT EXISTS interaction_history (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            user_role TEXT NOT NULL,
            question TEXT NOT NULL,
            timestamp DATETIME DEFAULT CURRENT_TIMESTAMP
        )
    """)
    conn.commit()
    return conn

def save_question(conn, user_role, question):
    cursor = conn.cursor()
    cursor.execute("""
        INSERT INTO interaction_history (user_role, question)
        VALUES (?, ?)
    """, (user_role, question))
    conn.commit()

def fetch_recent_questions(conn, user_role, limit=5):
    cursor = conn.cursor()
    cursor.execute("""
        SELECT question FROM interaction_history
        WHERE user_role = ?
        ORDER BY timestamp DESC
        LIMIT ?
    """, (user_role, limit))
    rows = cursor.fetchall()
    return [row[0] for row in rows]
