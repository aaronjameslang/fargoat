include .env
export

default:
	echo specify target >&2

build-image:
	docker build . -t ${PROJECT_NAME}

start-flask:
	./app.py

test-message:
	curl localhost:${PORT}/message?name=${USER}

test-report:
	curl --data name=${USER} localhost:${PORT}/report

start-sls-wsgi:
	sls wsgi serve -p ${PORT}
