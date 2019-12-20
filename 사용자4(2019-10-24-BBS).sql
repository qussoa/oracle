-- 사용자 4
/*
    id, pk
    작성일자
    작성시각
    작성자
    제목
    내용
    조회수
*/

CREATE TABLE tbl_bbs(
        bs_id       NUMBER            PRIMARY KEY,
        bs_date     VARCHAR2(10)       NOT NULL,  
        bs_time     VARCHAR2(10)        NOT NULL,
        bs_writer   nVARCHAR2(20)       NOT NULL,
        bs_subject  nVARCHAR2(125)      NOT NULL,
        bs_text     nVARCHAR2(1000)     NOT NULL,
        bs_count    NUMBER
);

CREATE SEQUENCE seq_bbs
START WITH 1 INCREMENT BY 1;