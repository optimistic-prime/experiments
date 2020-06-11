USER='postgresadmin' PASS='admin123'
HOST='postgres.default.svc.cluster.local'
DB='helm_info'

TABLE='helm_schema.helm_table'

helm ls -o json | jq -c '.[]' | grep unsupervised | while read -r line
do
  NAME=$(echo $line | jq -r .name)
  STATUS=$(echo $line | jq -r .status)
  APP_VERSION=$(echo $line | jq -r .app_version)
  LAST_UPDATE=$(echo $line | jq -r .updated | cut -d "." -f 1)

  PGPASSWORD=$PASS psql -U $USER -h $HOST -d $DB -p 5432 -c "IF (SELECT COUNT(*) FROM helm_schema.helm_table WHERE name = '$NAME') = 1 
                                                               UPDATE helm_schema.helm_table SET 
                                                                 status = '$STATUS', 
                                                                 app_version = '$APP_VERSION', 
                                                                 last_update = '$LAST_UPDATE' 
                                                               WHERE name = '$NAME', ;"
done

