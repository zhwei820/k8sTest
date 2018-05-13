

mkdir /etc/auth/ -p
mkdir /var/docker-store -p

docker run --entrypoint htpasswd registry:2 -Bbn myuser mypassword > /etc/auth/htpasswd

docker run -d -p 5000:5000 --restart=always --name registry_private  -v /etc/auth:/auth \
 -e "REGISTRY_AUTH=htpasswd"  -e "REGISTRY_AUTH_HTPASSWD_REALM=Registry Realm"  \
 -e "REGISTRY_AUTH_HTPASSWD_PATH=/auth/htpasswd"  \
 -e STORAGE_PATH=/tmp/docker-store -v /tmp/docker-store:/tmp/docker-store \
 registry:2


# docker login 192.168.1.5:5000


docker run -d \
  -p 8981:80 \
  -e REGISTRY_HOST=192.168.1.5 \
  -e REGISTRY_PORT=5000 \
  -e REGISTRY_PROTOCOL=http \
  -e SSL_VERIFY=false \
  -e ALLOW_REGISTRY_LOGIN=true \
  -e REGISTRY_ALLOW_DELETE=true \
  parabuzzle/craneoperator:latest

  
# for k8s 


kubectl create secret docker-registry myregistrykey --docker-server=192.168.1.5:5000 \
--docker-username=myuser --docker-password=mypassword --docker-email=zw@qqq.com  --namespace=default

# or
# not working
docker login 192.168.1.5:5000


echo '{"192.168.1.5:5000":{"username":"myuser","password":"mypassword","email":"zw@qqq.com","auth":"bXl1c2VyOm15cGFzc3dvcmQ="}}'| base64 

eyIxOTIuMTY4LjEuNTo1MDAwIjp7InVzZXJuYW1lIjoibXl1c2VyIiwicGFzc3dvcmQiOiJteXBhc3N3b3JkIiwiZW1haWwiOiJ6d0BxcXEuY29tIiwiYXV0aCI6ImJYbDFjMlZ5T20xNWNHRnpjM2R2Y21RPSJ9fQo=


vi se.yaml

apiVersion: v1
kind: Secret
metadata:
  name: myregistrykey
data:
  .dockercfg: eyIxOTIuMTY4LjEuNTo1MDAwIjp7InVzZXJuYW1lIjoibXl1c2VyIiwicGFzc3dvcmQiOiJteXBhc3N3b3JkIiwiZW1haWwiOiJ6d0BxcXEuY29tIiwiYXV0aCI6ImJYbDFjMlZ5T20xNWNHRnpjM2R2Y21RPSJ9fQo=
type: kubernetes.io/dockercfg