DESC tbl_memo;

ALTER TABLE tbl_memo ADD m_cat NVARCHAR2(50);

CREATE SEQUENCE seq_memo
START WITH 100 INCREMENT BY 1;

INSERT INTO tbl_memo(m_seq,m_subject,m_auth,m_date,m_time)
VALUES(SEQ_MEMO.NEXTVAL,'과제','QUSSOA','2019-12-02','15:00:00');

INSERT INTO tbl_memo(m_seq,m_subject,m_auth,m_date,m_time)
VALUES(SEQ_MEMO.NEXTVAL,'숙제','QUSSOA','2019-12-02','15:00:00');

INSERT INTO tbl_memo(m_seq,m_subject,m_auth,m_date,m_time)
VALUES(SEQ_MEMO.NEXTVAL,'영화보기','QUSSOA','2019-12-02','15:00:00');

commit;