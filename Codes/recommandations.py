import yaml
from openai import OpenAI
import os


def load_roles(filepath="Data/Roles.yaml"):
    with open(filepath, 'r', encoding='utf-8') as f:
        return yaml.safe_load(f)


def load_permissions(filepath="Data/Permissions.yaml"):
    with open(filepath, 'r', encoding='utf-8') as f:
        return yaml.safe_load(f)


def recommend_questions_with_context(user_role, history, schema_text, model="gpt-4"):
    roles = load_roles()
    permissions = load_permissions()
    client = OpenAI(api_key=os.getenv("OPENAI_API_KEY"))

    # Description du rôle
    role_description = roles.get(user_role, "Profil inconnu.")

    # Tables autorisées
    allowed_tables = permissions.get(user_role, {}).get("allow", [])

    # Historique sous forme de bullet list
    history_text = ""
    if history:
        history_text = "\nVoici les dernières questions posées par l'utilisateur :\n" + \
                       "\n".join([f"- {q}" for q in history])

    prompt = f"""
Tu es un assistant intelligent pour une organisation gérant des salles d’escalade.
Ton objectif est de recommander des questions **pertinentes, explorables en SQL**, adaptées au profil métier de l'utilisateur, à son historique, et aux données auxquelles il a accès.

Voici son rôle : **{user_role}**
Description du rôle : {role_description}

Tables de la base de données auxquelles ce rôle a accès : {', '.join(allowed_tables)}

{history_text}

Voici un extrait du schéma de base de données :
{schema_text}

👉 Génére 3 à 5 **questions métiers pertinentes** et exploitables par SQL, adaptées à ce profil.
Ne propose rien qui demanderait une table non autorisée.
Ne génère que des questions ! 
"""

    # Appel API LLM
    response = client.chat.completions.create(
        model=model,
        messages=[
            {"role": "user", "content": prompt}
        ],
        temperature=0.7
    )

    content = response.choices[0].message.content.strip()
    questions = [line.strip("-• ").strip() for line in content.splitlines() if line.strip()]
    return questions
