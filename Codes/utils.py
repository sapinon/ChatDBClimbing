from sqlalchemy import inspect
from db import engine  # Assurez-vous que le fichier db.py contient bien l'engine



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
