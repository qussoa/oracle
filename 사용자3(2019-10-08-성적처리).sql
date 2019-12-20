-- 여기는 USER3 화면입니다

CREATE TABLE tbl_score(
        
        s_num	VARCHAR2(3)		PRIMARY KEY,
        s_kor	NUMBER(3),		
        s_eng	NUMBER(3),		
        s_math	NUMBER(3)		

);

DESC tbl_score;

INSERT INTO tbl_score(s_num,s_kor,s_eng,s_math)
VALUES('001',90,60,80);
INSERT INTO tbl_score(s_num,s_kor,s_eng,s_math)
VALUES('002',90,60,80);
INSERT INTO tbl_score(s_num,s_kor,s_eng,s_math)
VALUES('003',90,60,80);
INSERT INTO tbl_score(s_num,s_kor,s_eng,s_math)
VALUES('004',90,60,80);
INSERT INTO tbl_score(s_num,s_kor,s_eng,s_math)
VALUES('005',90,60,80);
INSERT INTO tbl_score(s_num,s_kor,s_eng,s_math)
VALUES('006',90,60,80);
INSERT INTO tbl_score(s_num,s_kor,s_eng,s_math)
VALUES('007',90,60,80);
INSERT INTO tbl_score(s_num,s_kor,s_eng,s_math)
VALUES('008',90,60,80);

SELECT  *FROM tbl_score;

SELECT s_kor,s_eng,s_math,  
s_kor +s_eng+s_math AS 총점,
(s_kor +s_eng+s_math)/3 AS 평균
FROM tbl_score;

UPDATE tbl_score
SET s_kor = ROUND(DBMS_RANDOM.VALUE(50,100),0),
    s_eng = ROUND(DBMS_RANDOM.VALUE(50,100),0),
    s_math = ROUND(DBMS_RANDOM.VALUE(50,100),0);
    
SELECT * FROM tbl_score;

UPDATE tbl_score
SET s_math = 100
WHERE s_math = 94;

SELECT * FROM tbl_score;


UPDATE tbl_score
SET s_math = 94
WHERE s_num = '008';

SELECT * FROM tbl_score;

SELECT s_num, s_kor, s_eng, s_math,
 s_kor+ s_eng+ s_math AS 총점,
 ROUND((s_kor+ s_eng+ s_math) /3,0) AS 평균
 FROM tbl_score;
 
SELECT s_num, s_kor, s_eng, s_math,
 s_kor+ s_eng+ s_math AS 총점,
 ROUND((s_kor+ s_eng+ s_math) /3,0) AS 평균
 FROM tbl_score
 WHERE (s_kor+ s_eng+ s_math)/3 >= 80;
 
SELECT s_num, s_kor, s_eng, s_math,
 s_kor+ s_eng+ s_math AS 총점,
 ROUND((s_kor+ s_eng+ s_math) /3,0) AS 평균
 FROM tbl_score
 -- 계산한 결과 
 WHERE (s_kor+ s_eng+ s_math)/3 BETWEEN 70 AND 80;
 
 SELECT SUM(s_kor)
 FROM tbl_score;
 
 SELECT SUM(s_kor) AS 국어총점,
        SUM(s_eng) AS 영어총점,
        SUM(s_math) AS 수학총점
FROM tbl_score;


 SELECT SUM(s_kor) AS 국어총점,
        SUM(s_eng) AS 영어총점,
        SUM(s_math) AS 수학총점,
        SUM(s_kor+ s_eng+ s_math) AS 전체총점
FROM tbl_score;


 SELECT SUM(s_kor) AS 국어총점,
        SUM(s_eng) AS 영어총점,
        SUM(s_math) AS 수학총점,
        SUM(s_kor+ s_eng+ s_math) AS 전체총점,
        ROUND(AVG((s_kor+ s_eng+ s_math)/3),0 ) AS 전체평균
FROM tbl_score;

SELECT COUNT(*)
FROM tbl_score;

SELECT COUNT(s_num),COUNT(s_kor),COUNT(s_eng)
FROM tbl_score;

SELECT MAX(s_kor+ s_eng+ s_math) AS 최고점
FROM tbl_score;

SELECT MIN(s_kor+ s_eng+ s_math) AS 최저점
FROM tbl_score;


SELECT MAX(s_kor+ s_eng+ s_math) AS 최고점,
         MIN(s_kor+ s_eng+ s_math) AS 최저점
FROM tbl_score;

SELECT s_kor,s_eng,s_math,
         (s_kor+ s_eng+ s_math) AS 총점
FROM tbl_score;


 SELECT SUM(s_kor) AS 국어총점,
        SUM(s_eng) AS 영어총점,
        SUM(s_math) AS 수학총점,
        SUM(s_kor+ s_eng+ s_math) AS 전체총점,
        ROUND(AVG((s_kor+ s_eng+ s_math)/3),0 ) AS 전체평균
FROM tbl_score
WHERE s_kor+s_eng+s_math >= 200;


 SELECT SUM(s_kor) AS 국어총점,
        SUM(s_eng) AS 영어총점,
        SUM(s_math) AS 수학총점,
        SUM(s_kor+ s_eng+ s_math) AS 전체총점,
        ROUND(AVG((s_kor+ s_eng+ s_math)/3),0 ) AS 전체평균
FROM tbl_score
WHERE (s_kor+s_eng+s_math)/3 >= 70;

SELECT s_num,s_kor+s_eng+s_math AS 총점,
        RANK()OVER(ORDER BY(s_kor+s_eng+s_math) DESC)AS 석차
FROM tbl_score
ORDER BY s_num;

-- 중복값
SELECT s_num,s_kor+s_eng+s_math AS 총점,
        DENSE_RANK()OVER(ORDER BY(s_kor+s_eng+s_math) DESC)AS 석차
FROM tbl_score
ORDER BY s_num;

CREATE TABLE tbl_score2(

s_num	VARCHAR2(3)		PRIMARY KEY,
s_dept	VARCHAR2(3),		
s_kor	NUMBER(3),	
s_eng	NUMBER(3),		
s_math	NUMBER(3)		
);

CREATE TABLE tbl_dept(
d_num	VARCHAR2(3)		PRIMARY KEY,
d_name	nVARCHAR2(20)		not null,
d_pro	VARCHAR2(3)		
);
