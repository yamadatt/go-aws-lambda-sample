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
