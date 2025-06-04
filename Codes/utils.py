import os
import re

from sqlalchemy import inspect
from db import engine, run_sql_query  # Assurez-vous que le fichier db.py contient bien l'engine
from openai import OpenAI
OPENAI_API_KEY = os.getenv("OPENAI_API_KEY")

def get_completion(prompt, model, temperature=0.1):
    try:
        client = OpenAI(api_key=os.getenv("OPENAI_API_KEY"))

        llm_resp = client.chat.completions.create(
            model=model,
            messages=[{"role": "user", "content": prompt}],
            temperature = temperature
        )
        llm_resp = llm_resp.choices[0].message.content.strip()
        return llm_resp
    except Exception as e:
        print(llm_resp)

        return f"❌ Erreur lors de l'appel au modèle : {e}."

    return llm_resp

def prompt_correction(query, error_msg, full_schema):
    prompt_correction = f"""
    La requête SQL suivante a provoqué une erreur lorsqu'on l'a exécutée :
    ```sql
    {query}
    Message d’erreur retourné : « {error_msg} »

    Voici le schéma des tables disponible pour m’assurer que la correction est valide :
    {full_schema}
    
    Merci de proposer une version corrigée de cette requête SQL PostgreSQL, compatible avec les types de données en place. Ne modifie que ce qui est nécessaire pour lever l’erreur, et conserve l’objectif métier (par exemple, calculer la durée moyenne de session en heures). Ta réponse doit contenir uniquement la requête corrigée dans un bloc sql ; pas d’explication superflue.
    """

    return prompt_correction


def execute_auto_fixing_sql(query, full_schema, max_attempts=3):
    if query:
        corrected_query = query
        attempts = 0
        while attempts < max_attempts:
            try:
                results = run_sql_query(corrected_query)
                return results
            except Exception as exec_error:
                attempts += 1
                error_msg = str(exec_error)

                if attempts >= max_attempts:
                    final_answer = (
                        f"❌ Impossible d'exécuter la requête après {max_attempts} tentatives.\n"
                        f"Dernière requête SQL :\n```sql\n{corrected_query}\n```\n"
                        f"Message d'erreur : {error_msg}"
                    )
                    return final_answer
                else:
                    try:
                        pc = prompt_correction(query, error_msg, full_schema)
                        llm_resp = get_completion(pc, model="gpt-4.1", temperature=0)
                        sql_match = re.search(r"```sql\s*([\s\S]+?)```", llm_resp, re.IGNORECASE)
                        if sql_match:
                            corrected_query = sql_match.group(1).strip()
                        else:
                            # Si le LLM ne renvoie pas de bloc SQL, on abandonne
                            final_answer = (
                                "❌ Le modèle n'a pas renvoyé de requête SQL valide en réponse au message d'erreur.\n"
                                f"Réponse du modèle : {llm_resp}"
                            )
                            return final_answer
                    except Exception as exec_2:
                        final_answer = (
                            f"❌ Erreur lors de la correction automatique : {exec_2}\n"
                            f"Requête SQL actuelle :\n```sql\n{corrected_query}\n```"
                        )
                        print(final_answer)
                        return final_answer


#Va définir le prompt qui explique les data disponibles
def get_schema_description():
    inspector = inspect(engine)

    # 🧠 Description business explicite
    intro_text = """
Cette base de données modélise l’activité d’une organisation gérant plusieurs salles d’escalade.
Elle permet de suivre les visites des grimpeurs, leurs tentatives d’escalade, les caractéristiques des voies, ainsi que les profils des grimpeurs et leurs abonnements.

Elle est composée de deux tables de faits : Fact_VISIT_TRX (enregistre les visites en salle); Fact_RT_CLMB_LOG (enregistre les tentatives d’escalade sur les voies)
Et de cinq tables de dimensions : DIM_TIME (informations temporelles); DIM_MBS (types d’abonnement); DIM_CLMBR_PRFL (profils des grimpeurs); DIM_GYM (salles d’escalade); DIM_RT_CATLG (caractéristiques des voies)

Liens entre les tables :
- DIM_CLMBR_PRFL est liée à DIM_MBS via mem_type_cd, à Fact_VISIT_TRX et Fact_RT_CLMB_LOG via user_id
- Fact_VISIT_TRX est liée à DIM_GYM via gym_id et à DIM_TIME via visit_date
- Fact_RT_CLMB_LOG est liée à Fact_VISIT_TRX via visit_id et à DIM_RT_CATLG via rt_id
- DIM_RT_CATLG est liée à DIM_GYM via gym_id
"""
    schema_text = "\n📘 Schéma technique des tables sémantiques :\n"
    for table_name in ["definition_business_colonnes", "business_values_labels"]:
        if table_name in inspector.get_table_names():
            schema_text += f"\n🗂 Table: \"{table_name}\"\n"
            columns = inspector.get_columns(table_name)
            for column in columns:
                schema_text += f"  - \"{column['name']}\" ({column['type']})\n"

    return intro_text + schema_text
