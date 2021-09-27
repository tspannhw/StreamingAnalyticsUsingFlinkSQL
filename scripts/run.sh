#!/bin/bash

while :
do

        DATE=$(date +"%Y-%m-%d_%H%M")
        python3 -W ignore /home/nvidia/nvme/minifi-jetson-xavier/demo.py --camera /dev/video0 --network googlenet /home/nvidia/nvme/images/$DATE.jpg  2>/dev/null

        #java -jar IoTProducer-1.0-jar-with-dependencies.jar --serviceUrl pulsar://192.168.1.181:6650 --topic 'iotjetsonjson' --message "`tail -1 /home/nvidia/nvme/logs/demo1.log`"
        java -jar IoTProducer-1.0-jar-with-dependencies.jar --topic 'jetsoniot2' --serviceUrl pulsar+ssl://gke.sndev.snio.cloud:6651 --audience urn:sn:pulsar:sndev:gke --issuerUrl https://auth.streamnative.cloud --privateKey file:///home/nvidia/nvme/pulsar-demo/sndev-tspann.json --message "`tail -1 /home/nvidia/nvme/logs/demo1.log`"

        sleep 1
done
