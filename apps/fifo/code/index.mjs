import { EventBridgeClient, PutEventsCommand } from '@aws-sdk/client-eventbridge';

export const handler = async ( event, context ) => {
  console.log({ event, context });

  const wait = ( ms ) => new Promise( r => setTimeout( r, ms ) );

  const events = event.Records.map( record => record.body );

  console.log( 'start', events );

  await wait( 10e3 );

  console.log( 'stop', events );

  const client = new EventBridgeClient();

  const command = new PutEventsCommand({
    Entries: [
      {
        Time: new Date(),
        Source: 'service',
        Resources: [],
        DetailType: 'response',
        Detail: '{}',
        EventBusName: 'EventBus'
      }
    ]
  });

  const response = await client.send( command );

  console.log( 'response:', response );

  return {
    statusCode: 200,
    body: JSON.stringify('Hello from Lambda!')
  };
};
