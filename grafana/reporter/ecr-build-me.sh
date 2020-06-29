TAG=5

aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 249575051361.dkr.ecr.us-east-1.amazonaws.com

docker build -t tmp-reporter-romine .

docker tag tmp-reporter-romine:latest 249575051361.dkr.ecr.us-east-1.amazonaws.com/tmp-reporter-romine:$TAG

docker push 249575051361.dkr.ecr.us-east-1.amazonaws.com/tmp-reporter-romine:$TAG
