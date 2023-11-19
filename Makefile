AWS_STACK_NAME=aws-lambda-sample-golang
SRC_FOLDER=my-function

.PHONY: build
build:
	cd ${SRC_FOLDER} && $(MAKE) build

.PHONY: clean
clean:
	cd ${SRC_FOLDER} && $(MAKE) clean

.PHONY: cloud-build
cloud-build:
	sam build

.PHONY: cloud-deploy
cloud-deploy: cloud-build
	sam deploy \
 		--stack-name  ${AWS_STACK_NAME}\
  		--capabilities CAPABILITY_IAM \
   		--resolve-s3

.PHONY: cloud-test
cloud-test:
	./bin/cloud-test.sh

.PHONY: cloud-watch
cloud-watch:
	sam sync --stack-name ${AWS_STACK_NAME} --watch

.PHONY: cloud-destroy
cloud-destroy:
	sam delete --stack-name ${AWS_STACK_NAME}

.PHONY: cloud-traces
cloud-traces:
	sam traces --stack-name ${AWS_STACK_NAME}

.PHONY: cloud-logs
cloud-logs:
	sam logs --stack-name ${AWS_STACK_NAME}

.PHONY: cdktf-sehll
cdktf:
	cd infra-cdktf && pipenv shell

.PHONY: cdktf-deploy
cdktf-deploy: build
	cd infra-cdktf && cdktf deploy

.PHONY: cdktf-destroy
cdktf-destroy:
	cd infra-cdktf && cdktf destroy

.PHONY: tf-init
tf-init:
	export TF_VAR_AWS_STACK_NAME=${AWS_STACK_NAME}
	./bin/tf.sh init

.PHONY: tf-deploy
tf-deploy: build
	export TF_VAR_AWS_STACK_NAME=${AWS_STACK_NAME}
	./bin/tf.sh apply 

.PHONY: tf-destroy
tf-destroy: 
	export TF_VAR_AWS_STACK_NAME=${AWS_STACK_NAME}
	./bin/tf.sh destroy
