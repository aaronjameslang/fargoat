default:
	echo specify target >&2

build-image:
	./scripts/build-image.sh

run-server:
	docker run -it --rm --publish 5000:5000 fargoat ./server.py
	# -it is needed for ctrl-c

run-cli:
	docker run --rm fargoat ./cli.py ${USER}

push-image:
	./scripts/push-image.sh

deploy-sls:
	./scripts/deploy-sls.sh
