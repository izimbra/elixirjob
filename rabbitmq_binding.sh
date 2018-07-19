rabbitmqadmin declare queue name=hire_queue
rabbitmqadmin declare exchange name=apply_exchange type=direct
rabbitmqadmin declare binding source=“apply_exchange" destination_type="queue" destination="hire_queue" routing_key=""