# Récupérez l'ID du conteneur MySQL-server
MYSQL_CONTAINER_ID=$(docker ps -qf "name=mysql-server")

# Noms des services à vérifier
SERVICES=("customers-service" "vets-service" "visits-service")

# Vérifiez les conteneurs liés au réseau du conteneur MySQL-server
for service in "${SERVICES[@]}"; do
  CONTAINER_ID=$(docker ps -qf "name=$service")
  
  if [ "$CONTAINER_ID" != "" ]; then
    echo "Le service $service est lié au conteneur MySQL-server."
  else
    echo "Le service $service n'est pas lié au conteneur MySQL-server."
  fi
done
