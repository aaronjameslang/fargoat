build:
	docker build . -t fargoat

run:
	docker run -it --rm --publish 5555:5000 fargoat
	# -it is needed for ctrl-c

login:
	aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 268897920616.dkr.ecr.us-east-1.amazonaws.com
