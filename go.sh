#!/bin/bash

# Arrêter l'exécution en cas d'erreur
set -e

# Construire les applications
# Assurez-vous que le script build_apps est exécutable et à jour.
echo "Construction des applications..."
./build_apps.sh

# Exécuter les préparations Docker
# Ce script doit configurer tout ce qui est nécessaire pour Docker.
echo "Configuration de l'environnement Docker..."
./docker_apps.sh
# Lancer les conteneurs Docker avec docker-compose
# Assurez-vous que le fichier docker-compose.yml est configuré correctement.
echo "Lancement des conteneurs Docker..."
docker-compose --compatibility up

echo "Tous les services ont été lancés avec succès."
