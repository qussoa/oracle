SELECT * FROM   tbl_books;
/*
주소 테이블 생성
임의의 ID PK 설정    NUMBER
    이름             nVARCHAR2(50)
전화번호             nVARCHAR2(20)
주소                 nVARCHAR2(125)
관계                 nVARCHAR2(10)
*/
CREATE TABLE tbl_addr(
   a_id   NUMBER PRIMARY KEY,
   a_name nVARCHAR2(50),
   a_tel    nVARCHAR2(20),
   a_addr   nVARCHAR2(125),
   a_chain   nVARCHAR2(10)
   
);

DROP TABLE tbl_addr;
CREATE SEQUENCE SEQ_ADDR
START WITH 1 INCREMENT BY 1;