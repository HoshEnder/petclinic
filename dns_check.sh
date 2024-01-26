# Définissez les noms des conteneurs
containers=(customers-service vets-service visits-service mysql-server admin-server api-gateway discovery-server config-server)

# Bouclez sur chaque conteneur pour afficher leur configuration DNS
for container in "${containers[@]}"; do
    echo "Affichage de la configuration DNS pour $container:"
    docker exec -it "$container" cat /etc/resolv.conf
    echo "---"
done
