default:
	echo specify target >&2

build-image:
	./scripts/build-image.sh

run:
	docker run -it --rm --publish 5555:5000 fargoat
	# -it is needed for ctrl-c

push-image:
	./scripts/push-image.sh

deploy-sls:
	./scripts/deploy-sls.sh
