

mkdir auth

docker run --entrypoint htpasswd registry:2 -Bbn myuser mypassword > auth/htpasswd

docker run -d -p 5000:5000 --restart=always --name registry_private  -v `pwd`/auth:/auth  -e "REGISTRY_AUTH=htpasswd"  -e "REGISTRY_AUTH_HTPASSWD_REALM=Registry Realm"  -e "REGISTRY_AUTH_HTPASSWD_PATH=/auth/htpasswd"  registry:2


docker login localhost:5000


docker run -d \
  -p 8100:8100 \
  -e REGISTRY_HOST=192.168.1.5 \
  -e REGISTRY_PORT=5000 \
  -e REGISTRY_PROTOCOL=http \
  -e SSL_VERIFY=false \
  -e ALLOW_REGISTRY_LOGIN=true \
  -e REGISTRY_ALLOW_DELETE=true \
  parabuzzle/craneoperator:latest

  