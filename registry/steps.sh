

mkdir /etc/auth/ -p
mkdir /var/docker-store -p

docker run --entrypoint htpasswd registry:2 -Bbn myuser mypassword > /etc/auth/htpasswd

docker run -d -p 5000:5000 --restart=always --name registry_private  -v /etc/auth:/auth \
 -e "REGISTRY_AUTH=htpasswd"  -e "REGISTRY_AUTH_HTPASSWD_REALM=Registry Realm"  -e "REGISTRY_AUTH_HTPASSWD_PATH=/auth/htpasswd"  \
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

  
