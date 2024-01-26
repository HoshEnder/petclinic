docker-compose up -d config-server

# Cette commande exécute Maven pour nettoyer (supprimer le dossier target) et ensuite empaqueter 
# (compiler, tester, et créer un fichier JAR) le projet situé dans le dossier 
# spring-petclinic-visits-service. Le fichier pom.xml dans ce dossier est utilisé comme fichier POM.
mvn clean package -f spring-petclinic-visits-service/pom.xml  

# Cette commande fait la même chose que la précédente, mais pour le projet situé dans le dossier 
# spring-petclinic-vets-service. Le fichier pom.xml dans ce dossier est utilisé pour la configuration de Maven.
mvn clean package -f spring-petclinic-vets-service/pom.xml  

# Cette commande fonctionne de la même manière que les deux précédentes, ciblant cette fois 
# le projet dans le dossier spring-petclinic-customers-service.
mvn clean package -f spring-petclinic-customers-service/pom.xml  


# mvn clean package -f spring-petclinic-admin-server/pom.xml  
# mvn clean package -f spring-petclinic-api-gateway/pom.xml  
# mvn clean package -f spring-petclinic-config-server/pom.xml  
# mvn clean package -f spring-petclinic-discover-service/pom.xml  


docker stop config-server