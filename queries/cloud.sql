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
        min(CAST (cputempf as double)) as mincputempf, min( CAST(gputempf as double)) as mingputempf,
		max(CAST (cputempf as double)) as  maxcputempf, max( CAST(gputempf as double)) as maxgputempf
from jetsoniot2 /*+ OPTIONS('scan.startup.mode'='earliest') */
group by top1
