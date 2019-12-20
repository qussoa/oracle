CREATE TABLE tbl_score(
sc_seq      	NUMBER		PRIMARY KEY,
sc_name 	NVARCHAR2(50)	NOT NULL	,
sc_subject	NVARCHAR2(5)	NOT NULL,	
sc_score	    NUMBER	    NOT NULL	,
sc_sbcode	VARCHAR2(5),		
sc_stcode	VARCHAR2(5)		
);

desc tbl_score;

CREATE TABLE tbl_subject(
sb_code	VARCHAR2(5)		PRIMARY KEY,
sb_name	NVARCHAR2(50)	    NOT NULL	,
sb_pro	NVARCHAR2(50)		
);

SELECT * FROM tbl_score;

SELECT sc.sc_seq,sc.sc_name,sc.sc_score,sc.sc_subject,sb.sb_code,sb.sb_pro
FROM tbl_score SC, tbl_subject SB
WHERE sc.sc_subject = sb.sb_name;

CREATE TABLE tbl_student(
st_code	VARCHAR2(5)		PRIMARY KEY,
st_name	NVARCHAR2(50)	NOT NULL	,
st_tel	VARCHAR2(50)	,	
st_addr	nVARCHAR2(125),		
st_grade	NUMBER,		
st_dcode	VARCHAR(5)		
);

SELECT COUNT(*) FROM tbl_student;
SELECT * FROM tbl_student;

SELECT SC.sc_seq, sc.sc_name, st.st_tel,st.st_addr,st.st_grade,sb.sb_name,sb.sb_pro
FROM tbl_score SC
    LEFT JOIN tbl_subject SB
        ON sc.sc_subject = sb.sb_name
    LEFT JOIN tbl_student ST
        ON sc.sc_name = st.st_name
GROUP BY SC.sc_seq, sc.sc_name, st.st_tel,st.st_addr,st.st_grade,sb.sb_name,sb.sb_pro
ORDER BY sc.sc_seq;













        