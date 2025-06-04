from sqlalchemy import create_engine, text
from config import POSTGRES_URI
engine = create_engine(POSTGRES_URI)
import pandas as pd

def run_sql_query(query):
    print("OK")
    with engine.connect() as connection:
        return pd.read_sql_query(query, connection)


def fetch_metadata():
    col_query = """
    SELECT table_name, column_name, business_meaning
    FROM "definition_business_colonnes";
    """

    val_query = """
    SELECT table_name, column_name, label_value, business_meaning
    FROM "business_values_labels";
    """

    col_df = pd.read_sql_query(col_query, engine)
    val_df = pd.read_sql_query(val_query, engine)

    # ✅ Formatage pour le prompt
    column_text = "📘 Définition des colonnes :\n"
    for _, row in col_df.iterrows():
        column_text += f"- {row['table_name']}.{row['column_name']} : {row['business_meaning']}\n"

    value_text = "\n🔖 Valeurs métier explicitées :\n"
    for _, row in val_df.iterrows():
        value_text += f"- {row['table_name']}.{row['column_name']} = {row['label_value']} → {row['business_meaning']}\n"

    return column_text, value_text
