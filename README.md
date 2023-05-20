# aws

my collection of SAM applications

## Usage

`cd apps/<APP>`, then:

```bash
sam build
```

```bash
sam validate
```

```bash
sam deploy
```

```bash
sam logs -n HelloFunction --stack-name serverless-api --tail
```

```bash
sam delete --stack-name serverless-api
```

## Resources

[Spec](https://github.com/aws/serverless-application-model/blob/master/versions/2016-10-31.md)
[Generated Resources](https://github.com/aws/serverless-application-model/blob/master/docs/internals/generated_resources.rst)
