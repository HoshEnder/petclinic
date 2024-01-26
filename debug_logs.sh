#!/bin/bash

# Configuration des services
declare -A services=(
    ["config-server"]="8888"
    ["discovery-server"]="8761"
    ["mysql-server"]="3306"
    ["customers-service"]="8081"
    ["visits-service"]="8097"
    ["vets-service"]="8083"
    ["api-gateway"]="8080"
    ["admin-server"]="9090"
    ["tracing-server"]="9411"
    ["grafana-server"]="3000"
    ["prometheus-server"]="9091"
    # Ajoutez d'autres services si nécessaire
)

# Fonction pour vérifier la connectivité réseau et exporter les résultats
check_service_connectivity() {
    echo "Vérification de la connectivité pour les services..."
    for service in "${!services[@]}"; do
        if docker exec $service curl -s "http://$service:${services[$service]}" &> /dev/null; then
            echo "Le service $service est accessible." >> network_connectivity.txt
        else
            echo "Le service $service n'est pas accessible." >> network_connectivity.txt
        fi
    done
}

# Fonction pour extraire et analyser les logs et exporter les résultats
extract_and_analyze_logs() {
    echo "Extraction et analyse des logs des services..."
    for container in "${!services[@]}"; do
        docker logs $container | grep -E "error|failed|exception" | tail -n 50 >> all-services-logs.txt
        docker inspect $container  >> all-inspect-logs.txt
    done
}

# Vérification de la base de données et exportation des résultats
echo "Vérification de la base de données..."
mysql -h 127.0.0.1 -u petclinic -ppetclinicpassword -e "SHOW TABLES;" petclinic > db_verification.txt

# Vérification des données dans les tables et exportation des résultats
echo "Vérification des données dans les tables..."
tables=("owners" "pets" "specialties" "types" "vet_specialties" "vets" "visits")
for table in "${tables[@]}"; do
    mysql -h 127.0.0.1 -u petclinic -ppetclinicpassword -e "SELECT * FROM $table LIMIT 50;" petclinic > table_data_${table}.txt
done

# Appel des fonctions
check_service_connectivity
extract_and_analyze_logs

# Inclure le fichier docker-compose.yml
cp docker-compose.yml .

# Rechercher et archiver les fichiers application.yaml/application.yml
find . -type f \( -name "application.yaml" -o -name "application.yml" \) -exec sh -c 'mkdir -p "./config/$(dirname {})" && cp {} "./config/$(dirname {})"' \;

# Archivage des fichiers de résultats dans une archive zip
zip -m results_archive.zip network_connectivity.txt all-services-logs.txt all-inspect-logs.txt db_verification.txt $(printf "table_data_%s.txt " "${tables[@]}") docker-compose.yml $(find ./config -type f)

echo "Script terminé et les résultats archivés dans results_archive.zip."
