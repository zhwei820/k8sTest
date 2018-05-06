version=""
for LINE in `cat VERSION`
do   
    version=$LINE
done


docker build --force-rm -t 192.168.1.5:5000/starter:v$version . 

dangling=`docker images -f "dangling=true" -q`
echo $dangling
if [ "$dangling" != "" ]
then
docker rmi $(docker images -f "dangling=true" -q)

fi

echo 
echo image: 192.168.1.5:5000/starter:v$version


echo 
echo build ok!!!


docker push 192.168.1.5:5000/starter:v$version
echo 
echo push ok!!!

