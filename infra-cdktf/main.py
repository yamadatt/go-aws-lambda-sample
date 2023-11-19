#!/usr/bin/env python
# from constructs import Construct
import os

import cdktf
import constructs
from lib import tf_lambda
from cdktf_cdktf_provider_aws.provider import AwsProvider


AWS_STACK_NAME = os.environ.get("AWS_STACK_NAME","aws-lambda-sample-golang")
AWS_REGION = os.environ.get("AWS_REGION", "eu-west-1")


class MyStack(cdktf.TerraformStack):
    def __init__(self, scope: constructs.Construct, id: str):
        super().__init__(scope, id)

        AwsProvider(self, "aws",
                    region=AWS_REGION,
                    )

        self.posts = tf_lambda.LambdaConstruct(self, "lambda-fn",
                           AWS_STACK_NAME)


app = cdktf.App()
MyStack(app, "infra-cdktf")

app.synth()
