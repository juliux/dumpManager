SET LONG 1000000
SET LINESIZE 3000
SET PAGESIZE 0
SELECT 'XCOUNT'||','||COUNT(*) FROM dba_directories WHERE DIRECTORY_NAME='EXPORTECWN';
--SELECT 'YDIRECTORY'||','||DIRECTORY_PATH FROM dba_directories WHERE DIRECTORY_NAME='EXPORTECWN';