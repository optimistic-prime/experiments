from python:3.6-slim

#RUN apt update; apt install -y curl libpq-dev gcc postgresql vim jq
RUN apt update; apt install -y curl postgresql vim jq

# Install kubectl
RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl
RUN chmod +x ./kubectl
RUN mv ./kubectl /usr/local/bin/kubectl

# Install helm
RUN curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3
RUN chmod 700 get_helm.sh
RUN ./get_helm.sh

## used for python psql commands
#RUN pip install psycopg2

COPY insert_helm_info.sh .

CMD while true; do bash insert_helm_info; sleep 300; done
