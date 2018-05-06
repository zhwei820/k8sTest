
docker build --force-rm -t 192.168.1.5:5000/python3:v3.6 . 

dangling=`docker images -f "dangling=true" -q`
echo $dangling
if [ "$dangling" != "" ]
then
docker rmi $(docker images -f "dangling=true" -q)

fi

echo 
echo image: 192.168.1.5:5000/python3:v3.6

echo 
echo build ok!!!


docker push 192.168.1.5:5000/python3:v3.6