/** This is a row

sg:{"uuid": "xav_uuid_video0_gzm_20210924145705", "camera": "/dev/video0", "ipaddress": "192.168.1.183", 
"networktime": 24.993919372558594, "top1pct": 34.326171875, "top1": "monitor", "cputemp": "44.0",
"gputemp": "45.0", "gputempf": "113", "cputempf": "111", "runtime": "5", "host": "nvidia-desktop", 
"filename": "/home/nvidia/nvme/images/out_video0_kaa_20210924145705.jpg",
"imageinput": "/home/nvidia/nvme/images/img_video0_khe_20210924145705.jpg",
"host_name": "nvidia-desktop", "macaddress": "70:66:55:15:b4:a5",
"te": "5.301141262054443", "systemtime": "09/24/2021 10:57:10",
"cpu": 15.3, "diskusage": "33028.2 MB", 
"memory": 33.2}


*/


/** queries **/ 

select uuid, top1pct, top1,
cputemp,gputemp,gputempf,cputempf,runtime, TO_TIMESTAMP(systemtime,  'MM/dd/yyyy HH:mm:ss') as systime,cpu,diskusage,memory
from jetsoniot2 /*+ OPTIONS('scan.startup.mode'='earliest') */
where top1 in ('monitor','crane','modem','envelope','person','lakeside, lakeshore','racer, race car, racing car','tow truck, tow car, wrecker')
AND
CAST(cputempf as double) > 75

select cpu, uuid, cputempf, gputempf, diskusage, TO_TIMESTAMP(systemtime,  'MM/dd/yyyy HH:mm:ss'), runtime, top1, top1pct
from jetsoniot2  /*+ OPTIONS('scan.startup.mode'='earliest') */

select top1,
        min(cputempf) as mincputempf
from jetsoniot2 /*+ OPTIONS('scan.startup.mode'='earliest') */
group by top1

select uuid, camera, ipaddress, networktime, top1pct, top1,
cputemp,gputemp,gputempf,cputempf,runtime,host,filename,imageinput,
host_name,macaddress,te,systemtime,cpu,diskusage,memory
from jetsoniot2 /*+ OPTIONS('scan.startup.mode'='earliest') */
where top1 in ('monitor','crane','modem','envelope','person')

select uuid,  networktime, top1pct, top1,
cputemp,gputemp,gputempf,cputempf,runtime,te,systemtime,cpu,diskusage,memory
from jetsoniot2 /*+ OPTIONS('scan.startup.mode'='earliest') */
where top1 in ('monitor','crane','modem','envelope','person','laptop','joystick','menu','mouse,computer mouse')

select top1pct, top1,gputempf,cputempf,runtime,systemtime,cpu,diskusage,memory
from jetsoniot2 /*+ OPTIONS('scan.startup.mode'='earliest') */
where top1 in ('monitor','crane','modem','envelope','person','laptop','joystick','menu','mouse,computer mouse','seat belt, seatbelt')

select top1,
        min(CAST (cputempf as double)) as mincputempf, min(gputempf) as mingputempf
from jetsoniot2 /*+ OPTIONS('scan.startup.mode'='earliest') */
group by top1

select top1,
        avg(CAST (cputempf as double)) as avgcputempf, avg( CAST(gputempf as double)) as avggpttempf
from jetsoniot2 /*+ OPTIONS('scan.startup.mode'='earliest') */
group by top1

select top1,
        avg(CAST (cputempf as double)) as avgcputempf, avg( CAST(gputempf as double)) as avggputempf,
		avg(cpu) as avgcpu
from jetsoniot2 /*+ OPTIONS('scan.startup.mode'='earliest') */
group by top1

/*** Fast Queries ***/

select top1pct, top1,gputempf,cputempf,runtime,systemtime,cpu,diskusage,memory
from jetsoniot2 /*+ OPTIONS('scan.startup.mode'='earliest') */

select top1pct, top1,gputempf,cputempf,runtime,systemtime,cpu,diskusage,memory
from jetsoniot2 /*+ OPTIONS('scan.startup.mode'='earliest') */
where CAST(cputempf as double) > 75

select uuid, top1pct, top1,
cputemp,gputemp,gputempf,cputempf,runtime,systemtime,cpu,diskusage,memory
from jetsoniot2 /*+ OPTIONS('scan.startup.mode'='earliest') */
where top1 in ('monitor','crane','modem','envelope','person')

select uuid, top1pct, top1,
cputemp,gputemp,gputempf,cputempf,runtime,systemtime,cpu,diskusage,memory
from jetsoniot2 /*+ OPTIONS('scan.startup.mode'='earliest') */
where top1 in ('monitor','crane','modem','envelope','person')
AND
CAST(cputempf as double) > 75

select uuid, camera, ipaddress, networktime, top1pct, top1,
cputemp,gputemp,gputempf,cputempf,runtime,host,filename,imageinput,
host_name,macaddress,te,systemtime,cpu,diskusage,memory
from jetsoniot2 /*+ OPTIONS('scan.startup.mode'='earliest') */
where top1 in ('monitor','crane','modem','envelope','person')


/* lots of resources, not too fast */


SELECT top1, COUNT(*) AS ai_cnt FROM jetsoniot2 /*+ OPTIONS('scan.startup.mode'='earliest') */ GROUP BY top1


select uuid, top1pct, top1,
cputemp,gputemp,gputempf,cputempf,runtime,systemtime,cpu,diskusage,memory,PROCTIME()
from jetsoniot2 /*+ OPTIONS('scan.startup.mode'='earliest') */
where top1 in ('monitor','crane','modem','envelope','person')
AND
CAST(cputempf as double) > 75


/** dont run this one yet **/

select top1,
        avg(CAST (cputempf as double)) as avgcputempf, avg( CAST(gputempf as double)) as avggputempf,
        min(CAST (cputempf as double)) as mincputempf, min( CAST(gputempf as double)) as mingputempf,
		max(CAST (cputempf as double)) as  maxcputempf, max( CAST(gputempf as double)) as maxgputempf
from jetsoniot2 /*+ OPTIONS('scan.startup.mode'='earliest') */
group by top1
