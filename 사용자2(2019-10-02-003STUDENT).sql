-- 여기는 USER2 입니다

    CREATE TABLE tbl_student(
    st_num	VARCHAR2(5)	NOT NULL	PRIMARY KEY,
    st_name	nVARCHAR2(30)	NOT NULL	,
    st_addr	nVARCHAR2(125),
    st_grade	NUMBER(1)	,	
    st_height	NUMBER(3)	,	
    st_weight	NUMBER(3),		
    st_nick	nVARCHAR2(20),		
    st_nick_rem	nVARCHAR2(50),		
    st_dep_no	VARCHAR2(3)	NOT NULL	
    );
    
   
    INSERT INTO tbl_student(st_num,st_name,st_dep_no,st_grade)
    VALUES('A0001','홍길동','001',3);
    
    INSERT INTO tbl_student(st_num,st_name,st_dep_no,st_grade)
    VALUES('A0002','이몽룡','001',2);
    
    INSERT INTO tbl_student(st_num,st_name,st_dep_no,st_grade)
    VALUES('A0003','성춘향','002',1);
    
    INSERT INTO tbl_student(st_num,st_name,st_dep_no,st_grade)
    VALUES('A0004','장보고','003',2);
    
    INSERT INTO tbl_student(st_num,st_name,st_dep_no,st_grade)
    VALUES('A0005','임꺽정','003',3);
    
SELECT  * FROM tbl_student;

SELECT *FROM tbl_student ORDER BY st_name;

SELECT*FROM tbl_student WHERE st_num >='A0002' AND st_num<= 'A0004';
SELECT*FROM tbl_student WHERE st_num BETWEEN'A0002' AND 'A0004';

SELECT * FROM tbl_student WHERE st_grade= 2;
SELECT*FROM tbl_student WHERE st_num BETWEEN 'A0002' AND 'A0004' ORDER BY st_name;
SELECT*FROM tbl_student WHERE st_num BETWEEN 'A0002' AND 'A0004' ORDER BY st_grade DESC;

SELECT COUNT (*)
FROM tbl_student;

SELECT COUNT(*) FROM tbl_student
WHERE st_grade = 2;

SELECT MAX(st_grade) FROM tbl_student;
SELECT MIN(st_grade) FROM tbl_student;
SELECT SUM(st_grade) FROM tbl_student;
SELECT AVG(st_grade) FROM tbl_student;

SELECT 30+40 FROM dual;

SELECT *FROM DUAL;

SELECT 30*40 FROM tbl_student;

SELECT * FROM tbl_student;

-- 성춘향 학생의 주소 광주광역시로 이몽룡 주소를 익산시로 
-- 이몽룡 학생의 주소를 익산시로
-- 홍길동 학생의 주소를 서울 특별시로 

UPDATE tbl_student SET st_addr = '광주광역시'
WHERE st_name = '성춘향';


UPDATE tbl_student SET st_addr = '익산시'
WHERE st_name = '이몽룡';

UPDATE tbl_student SET st_addr = '서울특별시'
WHERE st_name = '홍길동';

SELECT * FROM tbl_student;

INSERT INTO tbl_student ( st_num,st_name,st_grade,st_dep_no)
VALUES('A0006','성춘향',2,'001');
SELECT * FROM tbl_student;

UPDATE tbl_student SET st_addr = '광주광역시'
WHERE st_name = '성춘향' AND st_grade =1;

SELECT * FROM tbl_student;


INSERT INTO tbl_student ( st_num,st_name,st_grade,st_dep_no)
VALUES('A0007','성춘향',2,'001');

SELECT * FROM tbl_student;


UPDATE tbl_student SET st_addr = '광주광역시'
WHERE st_name = '성춘향' AND st_dep =2;
SELECT * FROM tbl_student;

UPDATE tbl_student SET st_grade = 1
WHERE st_num = 'A0006';

SELECT * FROM tbl_student;