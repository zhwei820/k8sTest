#!/usr/bin/env bash
ls
version=""
for LINE in `cat VERSION`
do   
    version=$LINE
done

# env = dev/test/prod ...
# env_var = docker_registry_dev/docker_registry_test/docker_registry_prod ...

env_var=docker_registry_$env
image_registry=`eval echo  '$'$env_var`

image_name=$image_registry/starter:v$version.$BUILD_NUMBER

docker build --force-rm -t $image_name . 

dangling=`docker images -f "dangling=true" -q`
echo $dangling
if [ "$dangling" != "" ]
then
docker rmi $(docker images -f "dangling=true" -q)

fi

echo 
echo image: $image_name


echo 
echo build ok!!!


docker push $image_name
echo 
echo push ok!!!

