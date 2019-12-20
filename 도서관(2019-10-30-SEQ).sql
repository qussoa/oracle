CREATE TABLE tbl_books(
b_code	    VARCHAR2(6)	    NOT NULL	PRIMARY KEY,
b_name  	nVARCHAR2(125)	NOT NULL,	
b_auther 	nVARCHAR2(125)	NOT NULL,	
b_comp  	nVARCHAR2(125),		
b_year  	NUMBER	NOT NULL,	
b_iprice    	NUMBER,		
b_rprice    	NUMBER	NOT NULL	
);

CREATE TABLE tbl_users(
U_CODE  	VARCHAR2(6)     	NOT NULL	PRIMARY KEY,
U_NAME  	nVARCHAR2(125)	NOT NULL,	
U_TEL	    nVARCHAR2(125),		
U_ADDR  	nVARCHAR2(125)		
);

CREATE TABLE tbl_rent_book(
RENT_SEQ	             NUMBER	NOT NULL	 PRIMARY KEY,
RENT_DATE	             VARCHAR2(10)	NOT NULL,	
RENT_RETURN_DATE	 VARCHAR2(10)	NOT NULL,	
RENT_BCODE	         VARCHAR2(6)	NOT NULL,	
RENT_UCODE	         VARCHAR2(6)	NOT NULL,	
RENT_RETUR_YN	     VARCHAR2(1),		
RENT_POINT	         NUMBER		
);

SELECT * FROM tbl_books;
SELECT COUNT(*) FROM tbl_books;
SELECT * FROM tbl_users;
SELECT COUNT(*) FROM tbl_books;

ALTER TABLE tbl_rent_book
ADD CONSTRAINT Fk_BOOK
FOREIGN KEY (rent_bcode)
REFERENCES tbl_books(b_code);

ALTER TABLE tbl_rent_book
ADD CONSTRAINT Fk_USER
FOREIGN KEY (rent_ucode)
REFERENCES tbl_users(u_code);

SELECT MAX(rent_seq) FROM tbl_rent_book;
CREATE SEQUENCE SEQ_RENT_BOOK
START WITH 600 INCREMENT BY 1;


select * from tbl_rent_book
where rent_bcode = ? AND rent_rent_yn IS NULL;




