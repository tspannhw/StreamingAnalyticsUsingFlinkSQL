# StreamingAnalyticsUsingFlinkSQL

FLiP:   StreamNative:   Cloud-Native:   Streaming Analytics Using Apache Flink SQL on Apache Pulsar

## Running on NVIDIA XAVIER NX - 6 CPU, GPU, 8GB RAM

![Xavier](https://github.com/tspannhw/StreamingAnalyticsUsingFlinkSQL/raw/main/images/xavierjtop.jpg)


## Compile Java


```
jetson_clocks

mvn clean compile assembly:single

```

## Create Your Topic and Schema

![StreamNative Cloud Schema](https://github.com/tspannhw/StreamingAnalyticsUsingFlinkSQL/raw/main/images/iotschema.jpg)


## Run Python and Java

```

#!/bin/bash

while :
do

        DATE=$(date +"%Y-%m-%d_%H%M")
        python3 -W ignore /home/nvidia/nvme/minifi-jetson-xavier/demo.py --camera /dev/video0 --network googlenet /home/nvidia/nvme/images/$DATE.jpg  2>/dev/null

        java -jar IoTProducer-1.0-jar-with-dependencies.jar --topic 'jetsoniot2' --serviceUrl pulsar+ssl://cluster.org.snio.cloud:6651 --audience urn:sn:pulsar:org:cluster --issuerUrl https://auth.streamnative.cloud --privateKey file:///home/nvidia/nvme/pulsar-demo/org-tspann.json --message "`tail -1 /home/nvidia/nvme/logs/demo1.log`"

        sleep 1
done


```

## Create a Subscription and Confirm Data is Arriving

![StreamNative Cloud Consumer(https://github.com/tspannhw/StreamingAnalyticsUsingFlinkSQL/raw/main/images/browsingdata.jpg)


## Run Your Flink SQL

![StreamNative Cloud Flink SQL](https://github.com/tspannhw/StreamingAnalyticsUsingFlinkSQL/raw/main/images/streamnativecloud_flinksql2.jpg)

## Checks

```

jtop

```
