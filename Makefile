include .env
export

default:
	echo specify target >&2

build-image:
	./scripts/build-image.sh

deploy-sls:
	./scripts/deploy-sls.sh

push-image:
	./scripts/push-image.sh

run-async:
	docker run --rm fargoat ./async.py ${WH_URL} ${USER}

run-print:
	docker run --rm fargoat ./print.py ${USER}

run-serve:
	docker run --rm -it --publish 5000:80 fargoat ./serve.py
	# -it is needed for ctrl-c
	# --publish exposes to port
