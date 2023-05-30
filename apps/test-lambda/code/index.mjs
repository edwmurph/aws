const date1 = new Date().toISOString();

export const handler = async ( event, context ) => {
  console.log({ event, context });

  const date2 = new Date().toISOString();

  return {
    statusCode: 200,
    body: JSON.stringify({ message: 'hello world', date1, date2 })
  };
};
