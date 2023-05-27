import { DynamoDBClient } from '@aws-sdk/client-dynamodb';
import { PutCommand, DynamoDBDocumentClient } from '@aws-sdk/lib-dynamodb';

/**
 * Creating fx payment record in DynamoDB for further processing.
 */
export const handler = async ( event ) => {
  console.log( 'Received event:', JSON.stringify( event, null, 2 ) );

  const paymentId = 'PYID' + new Date().getTime().toString().substr( 2, 9 );
  const requestBody = JSON.parse( event.body || event );

  console.log( 'requestBody', typeof requestBody, requestBody );

  let statusCode = 200;

  const headers = {
    'Content-Type': 'application/json'
  };

  // eslint-disable-next-line max-len
  let message = 'Please use paymentId for getting latest status of your remittance by calling [GET] /fx-payments?paymentId=' + paymentId;

  try {
    const client = new DynamoDBClient({});

    const docClient = DynamoDBDocumentClient.from( client );

    const Item = {
      paymentId,
      destinationCurrency: requestBody.destinationCurrency,
      amount: requestBody.amount,
      payeeName: requestBody.payeeName,
      beneficiaryName: requestBody.beneficiaryName,
      beneficiaryBankName: requestBody.beneficiaryBankName,
      beneficiaryAccountNo: requestBody.beneficiaryAccountNo,
      quoteId: requestBody.quoteId,
      paymentStatus: 'FxPayment Created'
    };

    console.log( 'item', Item );

    const command = new PutCommand({
      TableName: 'fx-payments',
      Item
    });

    await docClient.send( command );
  } catch ( err ) {
    statusCode = 400;
    message = err.message;
  }

  return {
    statusCode,
    body: JSON.stringify({ message, paymentId }),
    headers
  };
};
