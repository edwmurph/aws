QUEUE_URL=$(aws sqs get-queue-url \
  --queue-name fifo.fifo \
  --profile edwmurph \
  | jq -r '.QueueUrl')

for i in {1..10}; do
  aws sqs send-message \
    --queue-url $QUEUE_URL \
    --profile edwmurph \
    --message-group-id 'test' \
    --message-body "{\"a\":\"$i\",\"b\":\"bb\"}"
  if [ $? -ne 0 ]; then
    return
  fi
done
