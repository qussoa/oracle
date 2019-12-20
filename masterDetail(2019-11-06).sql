-- Master Detail Table 관계 설정
CREATE TABLE tbl_master(
    m_seq number primary key,
    m_subject nVARCHAR2(1000) NOT NULL    
);

-- DEFAULT 
-- INSERT를 수행할 때 칼럼의 값을 지정하지 않으면
-- 기본값을 설정하라
CREATE TABLE tbl_detail(
    d_seq number primary key,
    d_nseq number not null,
    d_subject nVARCHAR2(1000) NOT NULL,
    d_ok VARCHAR2(1) DEFAULT 'N'
);

CREATE SEQUENCE SEQ_MASTER
START WITH 1
INCREMENT BY 1;

CREATE SEQUENCE SEQ_DETAIL
START WITH 1
INCREMENT BY 1;

ALTER TABLE tbl_detail 
ADD CONSTRAINT FK_MD
FOREIGN KEY (d_nseq)
REFERENCES tbl_master(m_seq);

INSERT INTO tbl_master(m_seq, m_subject)
VALUES (SEQ_MASTER.NEXTVAL,'다음중 OSI 7계층 중 가장 하위계층으로 맞는것은?');

SELECT * FROM tbl_master;

INSERT INTO tbl_detail(d_seq,d_nseq,d_subject)
VALUES(SEQ_DETAIL.NEXTVAL,seq_master.currval,'전승계층');
INSERT INTO tbl_detail(d_seq,d_nseq,d_subject)
VALUES(SEQ_DETAIL.NEXTVAL,seq_master.currval,'세션계층');
INSERT INTO tbl_detail(d_seq,d_nseq,d_subject,d_ok)
VALUES(SEQ_DETAIL.NEXTVAL,seq_master.currval,'물리계층','Y');
INSERT INTO tbl_detail(d_seq,d_nseq,d_subject)
VALUES(SEQ_DETAIL.NEXTVAL,seq_master.currval,'네트워크계층');

select * from tbl_detail;

SELECT * FROM tbl_master, tbl_detail
where tbl_master.m_seq = tbl_detail.d_nseq;

commit;

drop table tbl_master;
drop table tbl_detail;
drop sequence seq_master;
drop SEQUENCE seq_detail;


INSERT INTO tbl_master(m_seq, m_subject)
VALUES (SEQ_MASTER.NEXTVAL,'다음중 사용자의 데이터가 저장되는 메모리는?');

SELECT * FROM tbl_master;

INSERT INTO tbl_detail(d_seq,d_nseq,d_subject)
VALUES(SEQ_DETAIL.NEXTVAL,seq_master.currval,'ROM');
INSERT INTO tbl_detail(d_seq,d_nseq,d_subject,d_ok)
VALUES(SEQ_DETAIL.NEXTVAL,seq_master.currval,'RAM','Y');
INSERT INTO tbl_detail(d_seq,d_nseq,d_subject)
VALUES(SEQ_DETAIL.NEXTVAL,seq_master.currval,'cache');
INSERT INTO tbl_detail(d_seq,d_nseq,d_subject)
VALUES(SEQ_DETAIL.NEXTVAL,seq_master.currval,'Resister');
