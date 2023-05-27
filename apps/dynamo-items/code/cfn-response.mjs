import axios from 'axios';

export const SUCCESS = 'SUCCESS';
export const FAILED = 'FAILED';

export const send = async function ( event, context, status, response ) {
  return await axios.put( event.ResponseURL, {
    Status: status,
    Reason: 'See the details in CloudWatch Log Stream: ' + context.logStreamName,
    PhysicalResourceId: context.logStreamName,
    StackId: event.StackId,
    RequestId: event.RequestId,
    LogicalResourceId: event.LogicalResourceId,
    Data: response
  });
};
