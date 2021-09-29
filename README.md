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
## Create a New Topic

![StreamNative Cloud Create New Topic](https://github.com/tspannhw/StreamingAnalyticsUsingFlinkSQL/raw/main/images/createNewTopic.jpg)

## Create a New Subscription

![StreamNative Cloud Create New Subscription](https://github.com/tspannhw/StreamingAnalyticsUsingFlinkSQL/raw/main/images/createNewSub.jpg)

## Browse Data

![StreamNative Cloud Consumer](https://github.com/tspannhw/StreamingAnalyticsUsingFlinkSQL/raw/main/images/browsingdata.jpg)

## Created Schema

```
{
    "type": "record",
    "name": "IoTMessage",
    "namespace": "io.streamnative.examples.oauth2",
    "fields": [
        {
            "name": "camera",
            "type": [
                "null",
                "string"
            ],
            "default": null
        },
        {
            "name": "cpu",
            "type": "double"
        },
        {
            "name": "cputemp",
            "type": [
                "null",
                "string"
            ],
            "default": null
        },
        {
            "name": "cputempf",
            "type": [
                "null",
                "string"
            ],
            "default": null
        },
        {
            "name": "diskusage",
            "type": [
                "null",
                "string"
            ],
            "default": null
        },
        {
            "name": "filename",
            "type": [
                "null",
                "string"
            ],
            "default": null
        },
        {
            "name": "gputemp",
            "type": [
                "null",
                "string"
            ],
            "default": null
        },
        {
            "name": "gputempf",
            "type": [
                "null",
                "string"
            ],
            "default": null
        },
        {
            "name": "host",
            "type": [
                "null",
                "string"
            ],
            "default": null
        },
        {
            "name": "host_name",
            "type": [
                "null",
                "string"
            ],
            "default": null
        },
        {
            "name": "imageinput",
            "type": [
                "null",
                "string"
            ],
            "default": null
        },
        {
            "name": "ipaddress",
            "type": [
                "null",
                "string"
            ],
            "default": null
        },
        {
            "name": "macaddress",
            "type": [
                "null",
                "string"
            ],
            "default": null
        },
        {
            "name": "memory",
            "type": "double"
        },
        {
            "name": "networktime",
            "type": "double"
        },
        {
            "name": "runtime",
            "type": [
                "null",
                "string"
            ],
            "default": null
        },
        {
            "name": "systemtime",
            "type": [
                "null",
                "string"
            ],
            "default": null
        },
        {
            "name": "te",
            "type": [
                "null",
                "string"
            ],
            "default": null
        },
        {
            "name": "top1",
            "type": [
                "null",
                "string"
            ],
            "default": null
        },
        {
            "name": "top1pct",
            "type": "double"
        },
        {
            "name": "uuid",
            "type": [
                "null",
                "string"
            ],
            "default": null
        }
    ]
}
```


## Create a Flink SQL Table on Pulsar

```

CREATE TABLE jetsoniot3
(
  `id` STRING, uuid STRING, ir STRING,
  `end` STRING, lux STRING, gputemp STRING, 
  cputemp STRING, `te` STRING, systemtime STRING, hum STRING,
 memory STRING, gas STRING, pressure STRING, 
 `host` STRING, diskusage STRING, ipaddress STRING, macaddress STRING, 
  gputempf STRING, host_name STRING, camera STRING, filename STRING, 
    `runtime` STRING, cpu STRING,cputempf STRING, imageinput STRING,
    `networktime` STRING, top1 STRING, top1pct STRING, 
  publishTime TIMESTAMP(3) METADATA,
  WATERMARK FOR publishTime AS publishTime - INTERVAL '5' SECOND
) WITH (
  'topic' = 'persistent://public/default/jetsoniot2',
  'value.format' = 'json',
  'scan.startup.mode' = 'earliest'
)

CREATE TABLE topitems (
  uuid  STRING,
  top1 STRING, top1pct STRING, 
  camera STRING,
  systemtime STRING,
  cputempf STRING,
  gputempf STRING,
  insert_time TIMESTAMP(3)
)



```

## Run Your Flink SQL

![StreamNative Cloud Flink SQL](https://github.com/tspannhw/StreamingAnalyticsUsingFlinkSQL/raw/main/images/streamnativecloud_flinksql2.jpg)

```
select cputempf, gputempf, diskusage, cpu, systemtime, uuid
from jetsoniot2
where cputempf > 80


INSERT INTO jetsoniot2 VALUES
  (1, 100, 30.15, CURRENT_TIMESTAMP),
  (2, 200, 40, CURRENT_TIMESTAMP),
  (3, 300, 28000.56, CURRENT_TIMESTAMP),
  (4, 400, 42960.90, CURRENT_TIMESTAMP),
  (5, 500, 50000.1, CURRENT_TIMESTAMP),
  (6, 100, 688888888.7, CURRENT_TIMESTAMP),
  (7, 300, 20.99, CURRENT_TIMESTAMP),
  (8, 100, 6000, CURRENT_TIMESTAMP)
  
  
  select camera,
        max(cputempf) as maxcputempf, avg(cputempf) as avgcputtempf, min(cputempf) as mincputempf  
from jetsoniot2 
group by camera


select camera,
        max(cputempf) as maxcputempf
from jetsoniot2 /*+ OPTIONS('scan.startup.mode'='earliest') */
group by camera

select *
from jetsoniot2 /*+ OPTIONS('scan.startup.mode'='earliest') */

select camera,
        min(cputempf) as mincputempf
from jetsoniot2 /*+ OPTIONS('scan.startup.mode'='earliest') */
group by camera


```

## Checks

```

jtop

```


## Resources (Ops, DevOps, Management, Administration, SQL, Compute, Deploy)

* https://docs.streamnative.io/cloud/stable/compute/flink-sql
* https://docs.streamnative.io/cloud/stable/compute/flink-sql-cookbook
* https://docs.streamnative.io/cloud/stable/quickstart/quickstart-manager
* https://docs.streamnative.io/cloud/stable/quickstart/quickstart-snctl
* https://docs.streamnative.io/cloud/stable/use/topic
* https://flink.apache.org/2019/05/03/pulsar-flink.html 
* https://github.com/streamnative/pulsar-flink 
* https://streamnative.io/en/blog/release/2021-04-20-flink-sql-on-streamnative-cloud 
