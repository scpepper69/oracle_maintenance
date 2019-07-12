set line 1000
set pagesize 20000
col owner format a10
col object_name format a30
col sample_time format a30
col program format a20
col machine format a20

select
     o.owner
    ,o.object_name
    ,max(s.sample_time)
    ,s.sql_id
    ,s.program
    ,s.machine
from
     dba_hist_active_sess_history s
    ,dba_objects o
where 
      machine like '%%' 
  and (o.data_object_id = s.current_obj# or o.object_id = s.current_obj#)
--  and owner not in ('SYS','XDB','DVSYS','MDSYS')
group by
     o.owner
    ,o.object_name
    ,s.sql_id
    ,s.program
    ,s.machine
order by 3 desc
;
