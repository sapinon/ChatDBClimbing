import yaml
ROLES_FILE_PATH = "Data/Roles.yaml"
PERMISSIONS_FILE_PATH = "Data/permissions.yaml"

def load_roles_from_yaml(filepath):
    try:
        with open(filepath, 'r', encoding='utf-8') as file:
            return yaml.safe_load(file)
    except FileNotFoundError:
        print(f"❌ Fichier introuvable : {filepath}")
        return {}
    except yaml.YAMLError as e:
        print(f"❌ Erreur de lecture YAML : {e}")
        return {}

def ask_user_role():
    roles_dict = load_roles_from_yaml(ROLES_FILE_PATH)

    if not roles_dict:
        print("❌ Aucun rôle disponible.")
        exit(1)

    print("🧑‍💼 Qui êtes-vous ? Choisissez votre profil :")
    role_keys = list(roles_dict.keys())
    for i, role_name in enumerate(role_keys, start=1):
        print(f"{i}. {role_name}")

    # Demande de sélection
    role_index = input("Entrez le numéro correspondant à votre rôle : ").strip()
    while not role_index.isdigit() or int(role_index) not in range(1, len(role_keys)+1):
        print("❌ Choix invalide. Veuillez entrer un numéro valide.")
        role_index = input("Entrez le numéro correspondant à votre rôle : ").strip()

    selected_role = role_keys[int(role_index)-1]
    print(f"\n✅ Profil sélectionné : {selected_role}")
    print(f"ℹ️ {roles_dict[selected_role]}\n")

    return selected_role


def load_permissions(filepath=PERMISSIONS_FILE_PATH):
    try:
        with open(filepath, 'r', encoding='utf-8') as f:
            return yaml.safe_load(f)
    except FileNotFoundError:
        print(f"❌ Fichier de permissions non trouvé : {filepath}")
        return {}

def is_table_allowed(role, table_name, permissions):
    if role not in permissions:
        print(f"❌ Rôle {role} inconnu dans les permissions.")
        return False

    allowed = permissions[role].get("allow", [])
    denied = permissions[role].get("deny", [])

    if table_name in denied:
        return False
    if allowed and table_name not in allowed:
        return False
    return True

