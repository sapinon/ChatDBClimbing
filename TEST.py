from sqlalchemy import create_engine

engine = create_engine("postgresql://postgres:Mihaxulo7@localhost:5433/Climbing")

try:
    with engine.connect() as conn:
        print("✅ Connexion réussie à PostgreSQL")
except Exception as e:
    print("❌ Échec :", e)
