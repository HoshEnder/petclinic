(docker inspect customers-service && echo "---" &&
 docker inspect vets-service && echo "---" &&
 docker inspect visits-service && echo "---" &&
 docker inspect mysql-server && echo "---" &&
 docker inspect admin-server && echo "---" &&
 docker inspect api-gateway && echo "---" &&
 docker inspect discovery-server && echo "---" &&
 docker inspect config-server && echo "---") > container-inspects.txt
