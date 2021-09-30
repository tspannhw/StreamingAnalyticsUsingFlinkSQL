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

/* lots of resources */


SELECT top1, COUNT(*) AS ai_cnt FROM jetsoniot2 /*+ OPTIONS('scan.startup.mode'='earliest') */ GROUP BY top1



select top1,
        avg(CAST (cputempf as double)) as avgcputempf, avg( CAST(gputempf as double)) as avggputempf,
        min(CAST (cputempf as double)) as mincputempf, min( CAST(gputempf as double)) as mingputempf,
		max(CAST (cputempf as double)) as  maxcputempf, max( CAST(gputempf as double)) as maxgputempf
from jetsoniot2 /*+ OPTIONS('scan.startup.mode'='earliest') */
group by top1
