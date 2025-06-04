import os
import streamlit as st
from pathlib import Path
import re
import base64
import pandas as pd

from db import run_sql_query, fetch_metadata
from utils import get_schema_description, execute_auto_fixing_sql
from access_control import load_permissions, is_table_allowed
from history_manager import init_history_db, save_question
from recommandations import recommend_questions_with_context
from natural_to_sql import generate_sql_from_question, generate_natural_response
from config import OPENAI_API_KEY

from openai import OpenAI
client = OpenAI(api_key=OPENAI_API_KEY)

st.set_page_config(page_title="B2Data", page_icon="Data/Prises_Interface.png", layout="wide")
st.markdown("""
    <style>
    .chat-input-container {
        position: fixed;
        bottom: 0;
        left: 0;
        width: 100%;
        background-color: white;
        padding: 10px 1rem;
        border-top: 1px solid #ddd;
        z-index: 999;
    }
    .chat-input-container .element-container {
        margin-bottom: 0 !important;
    }
    </style>
""", unsafe_allow_html=True)
def get_image_base64(path):
    with open(path, "rb") as f:
        return base64.b64encode(f.read()).decode()

# Initialisation session
for key, default in {
    "page": "welcome",
    "role": None,
    "chat_history": [],
    "show_reasoning": False,
    "show_recommendations": False,
    "first_question_asked": False,
    "reset_main_question": False,
    "pending_clarification": None,
}.items():
    st.session_state.setdefault(key, default)

# Hide deploy menu etc.
st.markdown("""
<style>
#MainMenu, header, footer, .stDeployButton, .stActionButton { visibility: hidden; display: none !important; }
.block-container {padding-top: 1rem;}
</style>
""", unsafe_allow_html=True)

# Logo
logo_path = "Data/Logo_VF.png"
if Path(logo_path).exists():
    img_base64 = get_image_base64(logo_path)
    st.markdown(f"""
        <style>
        .fixed-logo {{position: fixed; bottom: 20px; right: 20px; z-index: 9999;}}
        </style>
        <div class="fixed-logo">
            <img src="data:image/png;base64,{img_base64}" width="140">
        </div>
    """, unsafe_allow_html=True)

# ---------------------- PAGE WELCOME ----------------------
if st.session_state.page == "welcome":
    st.markdown("<h2 style='text-align: center;'>🧗‍♀️ Bienvenue sur <span style='color:#FF0080;'>B2Data</span></h2>", unsafe_allow_html=True)
    st.markdown("<p style='text-align: center;'>Ce chatbot vous permet d’interroger les données relatives à vos salles d'escalade.</p>", unsafe_allow_html=True)

    col_img, col_info = st.columns([1, 1])
    with col_img:
        st.image("Data/Database_Interface.png", use_container_width=True)
    with col_info:
        st.markdown("<div style='background-color:#FF0080;color:white;padding:10px 20px;border-radius:8px;'>💬 Pour interagir avec les données, identifiez-vous.</div>", unsafe_allow_html=True)
        role = st.radio("Quel est votre rôle dans l'organisation ?", [
            "Directeur de l'organisation", "Manager des salles d'escalade", "Manager d'une salle",
            "Ouvreur/Routesetter", "Responsable marketing des salles", "Responsable accueil d'une salle"
        ], index=None)
        if st.button("✅ Valider mon rôle"):
            st.session_state.role = role
            st.session_state.page = "chatbot"
            st.session_state.chat_history = []
            st.rerun()

# ---------------------- PAGE CHATBOT ----------------------
elif st.session_state.page == "chatbot":
    if st.session_state.reset_main_question:
        st.session_state["main_question"] = ""         # vider le champ
        st.session_state.reset_main_question = False   # désactiver le drapeau
        st.rerun()

    col_empty, col_home = st.columns([10, 1])
    with col_home:
        if st.button("🏠 Accueil"):
            st.session_state.page = "welcome"
            st.rerun()


    if st.session_state.chat_history:
        st.markdown("### 💬 Historique de vos interactions")
        for q, r in st.session_state.chat_history:
            st.markdown(f"**🧗‍♀️Vous :** {q}")
            st.markdown(f"**🤖 B2Data :** {r}")
            st.markdown("---")

    st.markdown("### <span style='color:#FF0080;'>Comment puis-je vous aider ?</span>", unsafe_allow_html=True)

    conn = init_history_db()
    permissions = load_permissions()
    schema = get_schema_description()
    col_text, val_text = fetch_metadata()
    full_schema = schema + "\n" + col_text + "\n" + val_text



    st.markdown('<div class="chat-input-container">', unsafe_allow_html=True)

    chat_col1, chat_col2 = st.columns([5, 1])
    with chat_col1:
        question = st.text_area(
            "Pose ta question business 👇",
            key="main_question",
            height=70,
            label_visibility="collapsed"
        )
    with chat_col2:
        submit = st.button("📤", help="Envoyer la question")


    st.markdown("</div>", unsafe_allow_html=True)

    col_rec, col_reason = st.columns(2)
    with col_rec:
        if st.button("💡 Recommandations"):
            st.session_state.show_recommendations = not st.session_state.show_recommendations
            st.session_state.show_reasoning = False
    with col_reason:
        if st.session_state.first_question_asked:
            if st.button("🧠 Raisonnement"):
                st.session_state.show_reasoning = not st.session_state.show_reasoning
                st.session_state.show_recommendations = False

    #Traitement de la question
    if submit and question.strip():
        st.session_state["reset_main_question"] = True

        st.session_state.first_question_asked = True

        current_question = question.strip()

        history = st.session_state.chat_history
        result = generate_sql_from_question(current_question, full_schema, history)


        # Sinon on continue avec la vraie réponse
        answer = result.get("response", "❌ Erreur : la réponse attendue n’a pas été générée.")
        st.session_state.last_reasoning = result.get("reasoning", "")


        sql_match = re.search(r"```sql\s*([\s\S]+?)```", answer, re.IGNORECASE)
        sql_query = sql_match.group(1).strip() if sql_match else None

        if sql_query:
            tables_catalog = ['dim_time', 'dim_gym', 'fact_visit_trx', 'fact_rt_clmb_log', 'dim_rt_catlg', 'dim_mbs',
                              'dim_clmbr_prfl']


            def quote_identifiers(sql, identifiers):
                for ident in identifiers:
                    sql = re.sub(rf'\b{ident}\b(?!\")', f'"{ident}"', sql)
                return sql


            sql_query = quote_identifiers(sql_query, tables_catalog)
            tables_in_query = [t for t in tables_catalog if t.lower() in sql_query.lower()]
            unauthorized = [t for t in tables_in_query if not is_table_allowed(st.session_state.role, t, permissions)]

            if unauthorized:
                answer = "⛔ Vous n'avez pas accès aux données nécessaires."
            else:
                try:
                    results = execute_auto_fixing_sql(sql_query, full_schema, max_attempts=3)
                    results_str = results.to_string(index=False)
                    answer = generate_natural_response(
                        sql_results=results_str,
                        question=current_question,
                        user_role=st.session_state.role,
                        history=st.session_state.chat_history,
                        schema_info=full_schema
                    ) if not results.empty else "⚠️ Aucun résultat trouvé pour cette requête."
                    save_question(conn, st.session_state.role, current_question)
                except Exception as e:
                    answer = f"❌ Erreur SQL : {e}"
        elif "### QUESTIONS." in answer:
            st.session_state.pending_clarification = answer
            sub = "### QUESTIONS."
            idx = answer.find(sub)
            if idx != -1:
                answer = answer[idx + len(sub):]
            else:
                answer = ""
        elif "### REPONSE." in answer:
            sub = "### REPONSE."
            idx = answer.find(sub)
            if idx != -1:
                answer = answer[idx + len(sub):]
            else:
                answer = ""

        st.session_state.chat_history.append((current_question, answer))

        st.rerun()

    if st.session_state.show_reasoning and st.session_state.last_reasoning:
        st.markdown("### 🧠 Raisonnement")
        st.markdown(st.session_state.last_reasoning, unsafe_allow_html=True)

    if st.session_state.show_recommendations:
        recs = recommend_questions_with_context(
            user_role=st.session_state.role,
            history=[q for q, _ in st.session_state.chat_history],
            schema_text=full_schema
        )
        if recs:
            st.markdown("<div style='background-color:#FF0080;padding:12px 18px;border-radius:10px;color:white;'>💡 Suggestions basées sur votre rôle et vos questions précédentes :</div>", unsafe_allow_html=True)
            for r in recs:
                st.markdown(f"<p>{r}</p>", unsafe_allow_html=True)
