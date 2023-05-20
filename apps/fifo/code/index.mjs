export const handler = async ( event, context ) => {
  console.log({ event, context });

  const wait = ( ms ) => new Promise( r => setTimeout( r, ms ) );

  const events = event.Records.map( record => record.body );

  console.log( 'start', events );

  await wait( 10e3 );

  console.log( 'stop', events );

  return {
    statusCode: 200,
    body: JSON.stringify('Hello from Lambda!')
  };
};
