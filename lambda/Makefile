include .env
export

default:
	echo specify target >&2

# First install node and python deps
install:
	npm install
	python3.7 -m venv env
	. env/bin/activate && pip install -r requirements.txt

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
	docker build . -t ${PROJECT_NAME}:$(shell ./version.sh --new)

# We can call the docker image to test it
test-image-report:
	docker run --rm ${PROJECT_NAME}:$(shell ./version.sh) ./app.report.py ${USER}

deploy-vpc:
	serverless deploy -c vpc-serverless.yml
	( \
		echo -n SUBNET_ID_${STAGE}= | tr a-z A-Z ; \
		serverless info -v -c vpc-serverless.yml | \
		grep -Po '(?<=Subnet0Id: ).*$$' \
	) >> .env

deploy-ecs:
	serverless deploy -c ecs-serverless.yml

push-image:
	aws ecr get-login-password --region ${REGION} | \
	docker login --username AWS --password-stdin $(shell ./build-vars.js ecrUri)
	docker tag ${PROJECT_NAME}:$(shell ./version.sh) $(shell ./build-vars.js ecrImgUri)
	docker push $(shell ./build-vars.js ecrImgUri)

test-ecs-report:
	./src/run_report_task.py ${USER}
