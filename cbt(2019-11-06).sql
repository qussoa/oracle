create table tbl_cbt(
cb_num	number 		PRIMARY KEY,
cb_quest	Nvarchar2(1000)	NOT NULL,	
cb_ex1	nvaRCHAR2(1000)	NOT NULL,	
cb_ex2	nvaRCHAR2(1000)	NOT NULL,	
cb_ex3	nvaRCHAR2(1000)	NOT NULL,	
cb_ex4	nvaRCHAR2(1000)	NOT NULL,	
cb_answer	nvaRCHAR2(1000)	NOT NULL	
);

drop table tbl_cbt;

CREATE SEQUENCE seq_cbt
START WITH 21
INCREMENT BY 1;

commit;