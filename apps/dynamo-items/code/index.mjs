import { DynamoDBClient } from '@aws-sdk/client-dynamodb';
import { PutCommand, DynamoDBDocumentClient } from '@aws-sdk/lib-dynamodb';
import { send, SUCCESS, FAILED } from './cfn-response.mjs';

export const handler = async function ( event, context ) {
  try {
    console.log( JSON.stringify( event ) );

    if ( event.RequestType === 'Create' ) {
      console.log('upserting items into DynamoDB');

      const items = JSON.parse( event.ResourceProperties.Items.replace( '\n', '' ) );

      const client = new DynamoDBClient({});

      const docClient = DynamoDBDocumentClient.from( client );

      for ( const item of items ) {
        const command = new PutCommand({
          TableName: event.ResourceProperties.TableName,
          Item: item
        });

        console.log( await docClient.send( command ) );
      }
    }

    await send( event, context, SUCCESS, { Response: 'success - asdf' } );
  } catch ( e ) {
    console.error( e );
    await send( event, context, FAILED, { Response: 'failed - asdf' } );
  }
};
