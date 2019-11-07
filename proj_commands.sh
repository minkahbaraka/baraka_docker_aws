aws cloudformation create-stack --stack-name healthveritystack --capabilities CAPABILITY_IAM --template-body file://$PWD/healthverity_fullstack.yml

docker build -t healthverity-django .
docker image tag healthverity-django baraka215/healthverity-django
docker image push baraka215/healthverity-django

export DOCKER_HOST=tcp://<your EC2 ip address>:2375
docker-compose -f docker-compose.yml run djangoweb python /var/projects/compfinal/manage.py collectstatic
docker-compose -f docker-compose.yml run djangoweb python /var/projects/compfinal/manage.py migrate
docker-compose -f docker-compose.yml up -d
docker-compose -f docker-compose.yml down -v --rmi all
