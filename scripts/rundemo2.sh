#!/bin/bash
input="/home/nvidia/nvme/logs/demo1.log"
while IFS= read -r line
do
  java -jar IoTProducer-1.0-jar-with-dependencies.jar --topic 'jetsoniot2' --serviceUrl pulsar+ssl://gke.sndev.snio.cloud:6651 --audience urn:sn:pulsar:sndev:gke --issuerUrl https://auth.streamnative.cloud --privateKey file:///home/nvidia/nvme/pulsar-demo/sndev-tspann.json --message "$line"
done < "$input"
