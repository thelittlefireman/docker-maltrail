Docker with maltrail update periodicaly to be always up to date.

docker run -d --name maltrail -v /var/log/maltrail -e PASSWD=admin --net=host --privileged thelittlefireman/docker-maltrail