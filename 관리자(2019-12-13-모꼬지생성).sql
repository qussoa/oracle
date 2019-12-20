CREATE TABLESPACE mocoji_db
DATAFILE '/bizwork/oracle/data/mocoji.dbf'
SIZE 10M AUTOEXTEND ON NEXT 10K;

CREATE USER mocoji IDENTIFIED by mocoji
default tablespace mocoji_db;

grant DBA to mocoji;