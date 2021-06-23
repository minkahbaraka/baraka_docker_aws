aws cloudformation create-stack --stack-name baraka_docker_awsstack --capabilities CAPABILITY_IAM --template-body file://$PWD/baraka_docker_aws_fullstack.yml

docker build -t baraka_docker_aws-django .
docker image tag baraka_docker_aws-django baraka215/baraka_docker_aws-django
docker image push baraka215/baraka_docker_aws-django

export DOCKER_HOST=tcp://<your EC2 ip address>:2375
docker-compose -f docker-compose.yml run djangoweb python /var/projects/compfinal/manage.py collectstatic
docker-compose -f docker-compose.yml run djangoweb python /var/projects/compfinal/manage.py migrate
docker-compose -f docker-compose.yml up -d
docker-compose -f docker-compose.yml down -v --rmi all
