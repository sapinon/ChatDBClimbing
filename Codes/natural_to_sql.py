import re
from db import fetch_metadata
from openai import OpenAI
from config import OPENAI_API_KEY, OPENAI_MODEL

client = OpenAI(api_key=OPENAI_API_KEY)

def extract_section(text, marker):
    match = re.search(rf"{re.escape(marker)}(.*?)(?=\n[A-Z]\.|\Z)", text, re.DOTALL)
    return match.group(1).strip() if match else ""

def extract_sql_block(response_text):
    match = re.search(r"```sql\s*(.*?)\s*```", response_text, re.DOTALL)
    return f"```sql\n{match.group(1).strip()}\n```" if match else ""

def generate_sql_from_question(question, schema_info, history=None):
    col_text, val_text = fetch_metadata()
    combined_history = history[:] if history else []


    prompt = f"""Tu es un assistant intelligent spécialisé en données d’escalade et en génération de requêtes SQL PostgreSQL. 
    Tu aides les utilisateurs à poser les bonnes questions et à obtenir des réponses pertinentes, qu'elles soient basées sur les données ou simplement contextuelles.
    Objectif: comprendre la question de l'utilisateur, détecter si une requête SQL est nécessaire, et y répondre de manière utile et adaptée.
    Contexte base de données : Tu es dans une organisation qui gère 6 salles d'escalade et qui a ces données à dispositions: {schema_info}
    📊 Base de données à disposition — tables disponibles :
    - `dim_clmbr_prfl` : informations sur les grimpeurs (identité, genre, localisation, type d’abonnement, date de naissance). Utiliser la date de référence du 31/12/24 pour calculer son âge.
    - `dim_mbs` : catalogue des abonnements (code, nom, prix, remises)
    - `fact_visit_trx` : journal des visites des grimpeurs dans les salles (dates, heures, lieu)
    - `fact_rt_clmb_log` : tentatives d’escalade (grimpeur, voie, tentative, réussite ("ascnt_flg est un champ de type boolean contenant uniquement true ou false et pas de 0 ou 1)
    - `dim_rt_catlg` : catalogue des voies (style, difficulté, date d’ajout, ouvreur)
    - `dim_gym` : salles d’escalade (nom, capacité, ville)
    - `dim_time` : calendrier de référence (jour, trimestre, année)
    
    🔗 Structure relationnelle :
    La table dim_clmbr_prfl (profil des grimpeurs) est liée à fact_visit_trx et fact_rt_clmb_log via la colonne user_id, ce qui permet de relier chaque grimpeur à ses visites et à ses tentatives d'escalade.
    La table fact_visit_trx (journal des visites) est connectée à fact_rt_clmb_log grâce à visit_id, ce qui permet d’associer chaque tentative d’escalade à une visite précise.
    La colonne gym_id permet de faire le lien entre fact_visit_trx et dim_gym, indiquant dans quelle salle a eu lieu chaque visite.
    Les tentatives d’escalade dans fact_rt_clmb_log sont associées à une voie spécifique grâce au lien avec dim_rt_catlg via rt_id.
    Le type d’abonnement d’un grimpeur, présent dans dim_clmbr_prfl.mem_type_cd, est relié à dim_mbs, la table des abonnements.
    Les visites enregistrées dans fact_visit_trx sont datées via la colonne visit_date, qui correspond à la colonne date de la table dim_time.
    Enfin, les voies référencées dans dim_rt_catlg sont associées à une salle via la colonne gym_id, elle-même reliée à dim_gym
    
    📁 Documentation des colonnes et valeurs disponibles :
    {col_text}
    
    🧾 Dictionnaire business des valeurs :
    {val_text}

    Date de référence: 31 décembre 2024. (utile pour calculer l'âge des grimpeurs)
    
    Pour mieux comprendre la demande de l'utilisateur, tu dois parfois considérer l’historique de tes échanges avec :""" + "\n".join([f"- Utilisateur : {q}\n- Assistant : {r}" for q, r in combined_history[-3:]]) + f"""
    
    Répond à la question suivante: 
    {question}
    
    En suivant ces étapes :
    1. Analyser la question pour comprendre exactement l'intention de l'utilisateur - si tu ne comprends pas la question, que certains termes sont flous, demande à l'utilisateur des clarifications. Mais n'invente pas une interprétation. 
    2. Identifier le nom des tables et colonnes nécessaires dans la base de données pour répondre à la question
    3. Générer une requête PostgreSQL dans un bloc ```sql``` avec noms de colonnes en minuscules et sans guillemets.
    
    📌 Contraintes à respecter :
    - La requête doit être en SQL correct ! N'invente pas d'opérateurs,...
    - Tous les noms de tables et colonnes doivent être en minuscules, sans guillemets
    - Encapsule la requête dans un bloc ```sql``` à la fin
    - N'utilise que des noms de tables, colonnes et valeurs présents dans la base de données postgreSQL
    - Toutes les tables que tu utilises doivent être appelées dans la clause FROM
    
    🧠 Structure attendue dans ta réponse :
    A. Raisonnement pas à pas  
    B. Requête SQL commençant par ```sql
    """

    response = client.chat.completions.create(
        model=OPENAI_MODEL,
        messages=[{"role": "user", "content": prompt}],
        temperature=0
    ).choices[0].message.content.strip()

    return {
        "type": "final",
        "response": response,
        "reasoning": extract_section(response, "A.") + "\n\n" + extract_sql_block(response)
    }

def generate_natural_response(sql_results, question, user_role, history, schema_info):
    history_text = "\n".join([f"- Utilisateur : {q}\n- Assistant : {r}" for q, r in history[-3:]])

    prompt = f"""
Tu es un assistant intelligent qui aide un utilisateur à comprendre des résultats issus d'une base de données sur des salles d'escalade.

Tu connais :
- Le rôle de l'utilisateur : {user_role}
- La question posée : {question}
- Le schéma des données : {schema_info}

Voici l’historique récent des échanges :
{history_text}

Voici les résultats bruts issus d'une requête SQL :
{sql_results}

Formule une réponse en français, claire, adaptée à l'utilisateur et à son rôle, en expliquant ce que ces résultats signifient.
Ne répète pas les colonnes inutilement. Sois synthétique mais informatif.
"""

    completion = client.chat.completions.create(
        model=OPENAI_MODEL,
        messages=[{"role": "user", "content": prompt}],
        temperature=0
    )

    return completion.choices[0].message.content.strip()
