export const handler = async ( event ) => {
  const requestBody = JSON.parse( JSON.stringify( event ) );
  const lowFee = ( 0.14 / 100 ) * requestBody.amount;
  const fastFee = ( 0.38 / 100 ) * requestBody.amount;
  const responseBody = {
    message: 'Please use one of the QuoteID in your payment instructions.',
    option1:
      'QuoteID 1001 - low cost transfer for ' +
      requestBody.destinationCurrency +
      ` with fee of ${ lowFee.toFixed( 2 ) } USD`,
    option2:
      'QuoteID 1002 - fast and easy transfer for ' +
      requestBody.destinationCurrency +
      ` with fee of ${ fastFee.toFixed( 2 ) } USD`
  };

  let response = '';

  if ( requestBody.amount > 10000 || requestBody.amount < 50 ) {
    response = {
      statusCode: 400,
      body: 'Sorry, we cannot offer a quote for a transfer above $10000 or below $50'
    };
    throw new Error( JSON.stringify( response ) );
  } else {
    response = {
      statusCode: 200,
      body: JSON.stringify( responseBody )
    };
    return response;
  }
};
