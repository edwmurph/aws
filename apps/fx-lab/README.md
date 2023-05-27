# fx-lab

Base setup for a public REST API that is hooked up to a serverless backend.

awscurl \
  --profile edwmurph \
  --service execute-api \
  -X POST \
  -d '{"destinationCurrency": "GBP","amount": 1000}' \
  https://qbgcj9jj2a.execute-api.us-east-2.amazonaws.com/api/quotes

awscurl \
  --profile edwmurph \
  --service execute-api \
  -X POST \
  -d '{"destinationCurrency": "GBP","amount": 1000,"payeeName": "John","beneficiaryName": "Alex","beneficiaryBankName": "HSBC","beneficiaryAccountNo": "1234","quoteId": "1001"}' \
  https://z5md5g3jc2.execute-api.us-east-2.amazonaws.com/api/fx-payments


### payment-sqs-bridge test event

{"Records":[{"eventID": "c4ca4238a0b923820dcc509a6f75849b","eventName": "INSERT","eventVersion": "1.1","eventSource": "aws:dynamodb","awsRegion": "us-east-1","dynamodb": {"Keys": {"paymentId": {"S": "101"}},"NewImage": {"paymentStatus": {"S": "FxPayment Created"},"paymentId": {"S": "101"}},"ApproximateCreationDateTime": 1428537600,"SequenceNumber": "4421584500000000017450439091","SizeBytes": 26,"StreamViewType": "NEW_AND_OLD_IMAGES"},"eventSourceARN": "arn:aws:dynamodb:us-east-1:123456789012:table/ExampleTableWithStream/stream/2015-06-27T00:48:05.899"}]}
