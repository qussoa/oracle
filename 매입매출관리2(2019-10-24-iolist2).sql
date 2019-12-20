-- iolist2 화면

CREATE TABLE tbl_iolist(
        io_seq      	NUMBER	    	PRIMARY KEY,
        io_date	    VARCHAR2(10)	    NOT NULL,	
        io_pname	NVARCHAR2(25)	    NOT NULL,	
        io_dname	NVARCHAR2(25)	    NOT NULL,	
        io_dceo	    NVARCHAR2(25)	    NOT NULL,	
        io_inout	    NVARCHAR2(2)	    NOT NULL,	
        io_qty	    NUMBER	        NOT NULL,	
        io_price    	NUMBER,		
        io_total	    NUMBER		
);