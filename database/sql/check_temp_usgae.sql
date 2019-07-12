SELECT
     ss.sid
    ,ss.serial#
    ,ss.username
    ,tu.tablespace
    ,SUM(tu.blocks) * dts.block_size / 1024 / 1024 used_mb
    ,sq.sql_id
    ,sq.sql_text
FROM
    v$tempseg_usage tu
    ,v$session ss
    ,dba_tablespaces dts
    ,v$sql sq
WHERE
    tu.session_addr = ss.saddr
AND ss.sql_id = sq.sql_id
AND tu.tablespace = dts.tablespace_name
GROUP BY
     ss.sid
    ,ss.serial#
    ,ss.username
    ,dts.block_size
    ,tu.tablespace
    ,sq.sql_text
    ,sq.sql_id
ORDER BY
    ss.sid
;