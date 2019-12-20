create table tbl_comment(
c_seq	NUMBER		PRIMARY KEY,
c_contentid	nVARCHAR2(100)	NOT NULL	,
c_writer	nVARCHAR2(100)	NOT NULL,	
c_date	nVARCHAR2(100)	NOT NULL,	
c_text	nVARCHAR2(1000)	NOT NULL,	
c_areacode	nVARCHAR2(100)	,	
c_siguncode	nVARCHAR2(100)		


);