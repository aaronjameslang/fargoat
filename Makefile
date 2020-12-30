default:
	echo specify target >&2

build-image:
	./scripts/build-image.sh

run-server:
	docker run -it --rm --publish 5000:5000 fargoat ./server.py
	# -it is needed for ctrl-c

run-cli:
	docker run --rm fargoat ./cli.py ${USER}

run-wh:
	# . ./.env && docker run --rm fargoat ./webhook.py ${WH_URL} ${USER}
	. ./.env && docker run --rm fargoat ./webhook.py https://webhook.site/24a59289-4777-404b-9adb-92a5ad640194 ${USER}

push-image:
	./scripts/push-image.sh

deploy-sls:
	./scripts/deploy-sls.sh
