
lambdaの動作検証リポジトリ。

SAMを使用してAWS lambdaを動かす。デバッグのやり方などを試したくて検証。

2023年11月19日現在、S3のバケット一覧を表示できる。

## 使い方

２つコマンドを打つのは面倒なので、ローカルで以下のようにビルドして実行する。

```bash
sam build;sam local invoke
```

以下のように出力される。

```bash
START RequestId: 9e6486e3-5cc7-4071-8355-e5819c20efa5 Version: $LATEST
2023/11/19 12:01:55 Buckets:
2023/11/19 12:01:55 aws-sam-cli-managed-default-samclisourcebucket-atkakykvcyas : 2023-11-19 09:02:09 +0000 UTC
2023/11/19 12:01:55 lightkun-ecs-laravel-pj-terraform-tfstate : 2023-07-24 23:00:23 +0000 UTC
2023/11/19 12:01:55 radio-transcribe : 2019-12-08 03:37:40 +0000 UTC
2023/11/19 12:01:55 slack-yamada : 2022-07-08 13:44:05 +0000 UTC
2023/11/19 12:01:55 yamada-alb-logs : 2023-08-13 11:57:11 +0000 UTC
END RequestId: 9e6486e3-5cc7-4071-8355-e5819c20efa5
```

以下を参考にした。

[【Golang】AWS LambdaをSAMでデバッグする方法 \- Simple minds think alike](https://simple-minds-think-alike.moritamorie.com/entry/golang-lambda-vscode-debug#%E3%82%B5%E3%83%B3%E3%83%97%E3%83%AB%E3%83%97%E3%83%AD%E3%82%B8%E3%82%A7%E3%82%AF%E3%83%88)


[Go on AWS Lambda から AWS リソースを操作する \- log4ketancho](https://www.ketancho.net/entry/2018/05/29/080000)

---

以下、引用したリポジトリ。

https://github.com/vyacheslavisaev/go-aws-lambda-sample


# GO based AWS Lambda

## Documentaton
https://docs.aws.amazon.com/lambda/latest/dg/golang-handler.html

## Deploying
Deploying stack
```bash
make deploy
```

## Testing
Invoking function
```bash
make cloud-test
```

## Obtaining Logs
Requesting logs from stack
```bash
make cloud-logs
```

## Infrastructure

### Output

Get the stack exports trough
```bash
aws cloudformation list-exports
```
