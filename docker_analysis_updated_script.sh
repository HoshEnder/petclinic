
# Script mis à jour pour l'analyse des containers Docker basé sur le fichier docker-compose fourni

# 1. Vérification des Logs des Services
echo "Vérification des logs des services..."
(docker logs config-server && echo "---" &&
 docker logs discovery-server && echo "---" &&
 docker logs customers-service && echo "---" &&
 docker logs visits-service && echo "---" &&
 docker logs vets-service && echo "---" &&
 docker logs api-gateway && echo "---" &&
 docker logs tracing-server && echo "---" &&
 docker logs admin-server && echo "---" &&
 docker logs grafana-server && echo "---" &&
 docker logs prometheus-server && echo "---" &&
 docker logs mysql-server) > all-services-logs.txt

# 2. Inspection des Containers
echo "Inspection des containers..."
(docker inspect config-server && echo "---" &&
 docker inspect discovery-server && echo "---" &&
 docker inspect customers-service && echo "---" &&
 docker inspect visits-service && echo "---" &&
 docker inspect vets-service && echo "---" &&
 docker inspect api-gateway && echo "---" &&
 docker inspect tracing-server && echo "---" &&
 docker inspect admin-server && echo "---" &&
 docker inspect grafana-server && echo "---" &&
 docker inspect prometheus-server && echo "---" &&
 docker inspect mysql-server) > container-inspects.txt

# 3. Test de Connectivité des Services (Exemple avec curl)
echo "Test de connectivité pour les services..."
curl http://localhost:8888 # Config Server
curl http://localhost:8761 # Discovery Server
curl http://localhost:8081 # Customers Service
curl http://localhost:8097 # Visits Service
curl http://localhost:8083 # Vets Service
curl http://localhost:8080 # API Gateway
curl http://localhost:9411 # Tracing Server
curl http://localhost:9090 # Admin Server
curl http://localhost:3000 # Grafana Server
curl http://localhost:9091 # Prometheus Server

# 4. Vérification de la Base de Données (Commandes MySQL)
echo "Vérification de la base de données..."
mysql -h 127.0.0.1 -u petclinic -ppetclinicpassword -e "SHOW TABLES;" petclinic
mysql -h 127.0.0.1 -u petclinic -ppetclinicpassword -e "SELECT * FROM table_name;" petclinic # Remplacer table_name par le nom de la table à vérifier

# 5. Vérification de la Configuration du Frontend
# Note: Cette étape dépend fortement de la structure et de la technologie utilisée dans le frontend. 
# Les commandes spécifiques devraient être ajoutées en fonction du contexte du projet.

echo "Script terminé."
