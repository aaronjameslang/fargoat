include .env
export

default:
	echo specify target >&2

# First install node and python deps
install:
	./install.sh

# Now be sure to activate the python env:
# . ./env/bin/activate

# Next start the app
start-flask:
	./app.py

# With the app running, you can test the endpoints
test-local-message:
	curl localhost:${PORT}/message?name=${USER}
test-local-report:
	curl --data name=${USER} localhost:${PORT}/report

# Now we can instead start the app via wsgi,
#   similar to how the lambda will run, but offline
start-sls-wsgi:
	serverless wsgi serve -p ${PORT} -c sls.lambda.yml

# Next deploy the app to the cloud,
#   the output will tell you the cloud endpoint, which you can call
deploy-lambda:
	serverless deploy -c sls.lambda.yml

# Now we have split out the report, let's build the docker image
build-image:
	docker build . -t ${PROJECT_NAME}:$(shell ./version.sh)

# We can call the docker image to test it
test-image-report:
	docker run --rm ${PROJECT_NAME} ./app.report.py ${USER}
