create table tbl_user(
u_id        	nVARCHAR2(50)		PRIMARY KEY,
u_password	nVARCHAR2(125)	NOT NULL	
);

create table tbl_info(
i_userid    	nVARCHAR2(50)		PRIMARY KEY,
i_cmt	    nVARCHAR2(125)	NOT NULL,	
i_mcode 	nVARCHAR2(8)	    NOT NULL,	
i_date	    nVARCHAR2(20)	    NOT NULL	
);

select * from tbl_user
left join tbl_info
on u_id = i_userid;

alter table tbl_user
add CONSTRAINT USER_FK
FOREIGN key (u_id)
REFERENCES tbl_info(i_userid);