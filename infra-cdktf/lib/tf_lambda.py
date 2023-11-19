import os
import os.path as Path
import json
import constructs
from cdktf import TerraformAsset, AssetType
from cdktf_cdktf_provider_aws.iam_role import IamRole, IamRoleInlinePolicy
from cdktf_cdktf_provider_aws.iam_role_policy_attachment import IamRolePolicyAttachment
from cdktf_cdktf_provider_aws.lambda_function import LambdaFunction, LambdaFunctionEnvironment


class LambdaConstruct(constructs.Construct):
    apiEndPoint: str

    def __init__(self, scope: constructs.Construct, id: str, stack_name: str):
        super().__init__(scope, id)

        role = IamRole(self, "lambda-exec",
                       name=f"{stack_name}lambda-exec",
                       assume_role_policy=json.dumps({
                           "Version": "2012-10-17",
                           "Statement":
                               {
                                   "Action": "sts:AssumeRole",
                                   "Principal": {
                                       "Service": "lambda.amazonaws.com",
                                   },
                                   "Effect": "Allow",
                                   "Sid": "",
                               },
                       }),
                       # inline_policy=[ ],
                       )

        IamRolePolicyAttachment(self, "lambda-managed-policy",
                                policy_arn="arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole",
                                role=role.name,
                                )

        asset = TerraformAsset(self, "lambda-asset",
                               path=Path.join(os.getcwd(), "../my-function/bin"),
                               type=AssetType.ARCHIVE,
                               )

        new_lambda = LambdaFunction(self, "api",
                                    function_name=f"{stack_name}",
                                    handler="bootstrap",
                                    runtime="provided.al2",
                                    role=role.arn,
                                    filename=asset.path,
                                    source_code_hash=asset.asset_hash,
                                    environment=LambdaFunctionEnvironment(
                                        variables={"DYNAMODB_TABLE_NAME": "test_table"}
                                    )
                                    )
