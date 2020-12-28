build:
	docker build . -t fargoat

run:
	docker run -it --rm --publish 5555:5000 fargoat
	# -it is needed for ctrl-c

login:
	aws ecr get-login-password --region ca-central-1 | docker login --username AWS --password-stdin 268897920616.dkr.ecr.ca-central-1.amazonaws.com

docker-push:
	docker tag fargoat:latest \
		268897920616.dkr.ecr.ca-central-1.amazonaws.com/fargoat-repo0:latest
	docker push \
		268897920616.dkr.ecr.ca-central-1.amazonaws.com/fargoat-repo0:latest

deploy:
	serverless deploy --stage dev
