#!/bin/bash

# Fonctions utilitaires
log_error() {
    echo "Erreur : $1" >&2
}

# Définir les détails de connexion MySQL
db_container="mysql-server"
mysql_db="petclinic"
mysql_root_password="${MYSQL_ROOT_PASSWORD:-rootpassword}"  # Utiliser une variable d'environnement, si disponible

# Vérifier si le conteneur MySQL est en cours d'exécution
if ! docker inspect -f '{{.State.Running}}' $db_container &>/dev/null; then
    log_error "Le conteneur MySQL ($db_container) n'est pas en cours d'exécution."
    exit 1
fi

# Réinitialiser la base de données
echo "Réinitialisation de la base de données..."
docker exec $db_container sh -c "mysql -u root -p$mysql_root_password -e 'DROP DATABASE IF EXISTS $mysql_db; CREATE DATABASE $mysql_db;'"

# Répertoire contenant les dossiers des services
services_dir="$(pwd)"

# Exécuter un fichier SQL spécifique
execute_sql_file() {
    local file=$1
    docker cp "$file" $db_container:/tmp/
    if ! docker exec $db_container sh -c "mysql -u root -p$mysql_root_password $mysql_db < /tmp/$(basename $file)"; then
        log_error "Échec de l'exécution de $(basename $file)"
        return 1
    else
        echo "Succès de l'exécution de $(basename $file)"
    fi
}

# Fonction pour trouver et exécuter des fichiers SQL
execute_sql_files() {
    local pattern=$1
    find "$services_dir" -type f -name "$pattern" -print0 | while IFS= read -r -d $'\0' file; do
        echo "Exécution du fichier SQL : $file"
        execute_sql_file "$file" || continue
    done
}

# Exécuter tous les fichiers schema.sql, puis tous les fichiers data.sql
echo "Exécution des fichiers schema.sql..."
execute_sql_files "schema.sql"

echo "Exécution des fichiers data.sql..."
execute_sql_files "data.sql"

echo "Tous les scripts SQL ont été traités."
