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
  https://yks2ctrle9.execute-api.us-east-2.amazonaws.com/api/fx-payments
