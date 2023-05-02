from confluent_kafka import Consumer, KafkaError

conf = {
    'bootstrap.servers': 'localhost:9092',
    'group.id': 'my-group',
    'auto.offset.reset': 'earliest'
}

consumer = Consumer(conf)
consumer.subscribe(['my-topic'])

while True:
    msg = consumer.poll(1.0)

    if msg is None:
        continue
    if msg.error():
        if msg.error().code() == KafkaError._PARTITION_EOF:
            print('End of partition reached {0}/{1}'
                  .format(msg.topic(), msg.partition()))
        else:
            print('Error while consuming message: {0}'.format(msg.error()))
    else:
        print('Received message: {0}'.format(msg.value().decode('utf-8')))


In this example, we create a Kafka consumer using the bootstrap.servers, group.id, and auto.offset.reset configuration parameters. We then subscribe to a Kafka topic named my-topic. In the main loop, we use consumer.poll() to read messages from the Kafka topic. If there are no messages, we continue to the next iteration of the loop. If there is an error, we print an error message. Otherwise, we print the value of the message to the console.

You can customize this code to meet your specific requirements, such as by processing the messages in a different way or writing them to another destination instead of printing them to the console.
