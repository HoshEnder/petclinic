(docker logs customers-service | tail -n 50 && echo "---" && 
 docker logs vets-service | tail -n 50 && echo "---" && 
 docker logs visits-service | tail -n 50 && echo "---" && 
 docker logs mysql-server | tail -n 50 && echo "---" && 
 docker logs admin-server | tail -n 50 && echo "---" && 
 docker logs api-gateway | tail -n 50 && echo "---" && 
 docker logs discovery-server | tail -n 50 && echo "---" && 
 docker logs config-server | tail -n 50 && echo "---") > recent-logs.txt
