# Recherche des conteneurs Docker écoutant sur le port 3306
containers=$(docker ps --filter "expose=3306" -q)

# Vérification s'il y a des conteneurs à supprimer
if [ -z "$containers" ]; then
    echo "Aucun conteneur écoutant sur le port 3306 trouvé."
else
    # Suppression des conteneurs trouvés
    echo "Suppression des conteneurs suivants : $containers"
    docker rm -f $containers
fi

docker rmi -f spring-customers
docker rmi -f spring-vets
docker rmi -f spring-visits
docker rmi -f spring-config

docker rm -f visits-service
docker rm -f vets-service
docker rm -f customers-service
docker rm -f config-server



docker build --squash -t spring-customers -f spring-petclinic-customers-service/Dockerfile spring-petclinic-customers-service/.  
docker build --squash -t spring-vets -f spring-petclinic-vets-service/Dockerfile spring-petclinic-vets-service/.  
docker build --squash -t spring-visits -f spring-petclinic-visits-service/Dockerfile spring-petclinic-visits-service/.  
docker build --squash -t spring-config -f spring-petclinic-config-server/Dockerfile spring-petclinic-config-server/.  