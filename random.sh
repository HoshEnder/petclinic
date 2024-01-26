#!/bin/bash

# Définir le répertoire de base pour les fichiers SQL (répertoire actuel)
base_dir="$(pwd)"

# Nom de l'archive finale
final_archive="sql_files_archive.zip"

# Initialiser un compteur pour nommer les dossiers
counter=1

# Trouver et regrouper les fichiers SQL dans les dossiers "mysql"
find "$base_dir" -type f \( -path "*/mysql/schema.sql" -o -path "*/mysql/data.sql" \) -print0 | while IFS= read -r -d $'\0' file; do
    # Créer un répertoire pour les fichiers SQL
    sql_dir="${base_dir}/sql_folder_$counter"
    mkdir -p "$sql_dir"

    # Copier le fichier SQL dans le répertoire
    cp "$file" "$sql_dir"

    # Incrementer le compteur
    ((counter++))
done

# Créer une archive zip avec tous les dossiers sql_folder_*
zip -r "$final_archive" $(find . -type d -name "sql_folder_*")

# Nettoyer les répertoires sql_folder_*
find . -type d -name "sql_folder_*" -exec rm -rf {} +

echo "L'archive SQL a été créée : $final_archive"
