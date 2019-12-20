-- GRADE 화면

-- DB 이론상 정규화 과정
/*
1. 실무에서 사용하던 엑셀 데이터
=====================================
학생이름 학년   학과    취미
-------------------------------------
홍길동    3    컴공과   낚시,등산,독서

2. 엑셀 데이터를 단순히 DBMS 테이블로 구현
    - 만약 취미가 4개인 학생은 4개중 3개만 선택해야한다
    - 취미가 3개 미만인 학생은 사용하지 않는 칼럼이 있어 낭비되는 상황
=================================================
학생이름 학년   학과    취미1    취미2    취미3
-------------------------------------------------
홍길동    3    컴공과   낚시     등산      독서

3. 제1화 정규화가 수행된 TABLE 스키마
============================
학생이름 학년   학과    취미
----------------------------
홍길동    3    컴공과   낚시
홍길동    3    컴공과   등산
홍길동    3    컴공과   독서

-- 제 2 정규화
테이블의 고정값을 다른 테이블로 분리하고
테이블간의 join을 통해 view 생성하도록
구조적 변경을 하는 작업
tbl_student
============================
학생이름 학년   학과    취미
----------------------------
홍길동    3    001      001
홍길동    3    001      002
홍길동    3    001      003
성춘향    2    002      003

tbl_hobby
===========================
CODE         취미
---------------------------
001           낚시
002           등산
003           독서
===========================

tbl_dept
===========================
CODE   학과명   교수
---------------------------
001     컴공과
002     정보통신과
*/
DESC tbl_score;
/*
이름        널?       유형            
--------- -------- ------------- 
S_ID        NOT NULL  NUMBER        
S_STD       NOT NULL  NVARCHAR2(50) 
S_SUBJECT  NOT NULL NVARCHAR2(50) 
S_SCORE    NOT NULL NUMBER(3)     
S_REM                NVARCHAR2(50) 

성적일람표 table의 데이터중에서 과목항목을
제2정규화 작업 수행
*/

-- tbl_score 과목명만 추출하기
SELECT s_subject
FROM tbl_score
GROUP BY s_subject;



-- tbl_score 추출된 과목명을 저장할 TABLE 생성
CREATE TABLE tbl_subject(
sb_code	VARCHAR2(4)	PRIMARY KEY,
sb_name	Nvarchar2(20)	NOT NULL,
sb_pro	Nvarchar2(20)		
);

SELECT * FROM tbl_subject;

-- tbl_score에서 tbl_subject 테이블 데이터를 생성완료
-- 생성된 tbl_subject와 tbl_score 연결 테스트

SELECT *FROM tbl_score SC, tbl_subject SB
WHERE sc.s_subject = sb.sb_name;

SELECT COUNT(*) FROM tbl_score;
SELECT COUNT(*)
FROM tbl_score SC, tbl_subject SB
WHERE sc.s_subject = sb.sb_name;

-- tbl_score의 s_subject 칼럼에 있는 과목명을 코드로 변경하는 작업
-- 1. 임시로 칼럼 tbl_score추가
--    tbl_subject의 sb_code 칼럼과 구조(형식)가 같은 칼럼을 추가  
ALTER TABLE tbl_score ADD s_sbcode VARCHAR2(4);

SELECT * FROM tbl_score;

-- tbl_subject 테이블에서 과목명을 조회하여 해당하는 과목코드를 
-- tbl_score 테이블의 s_sbcode 칼럼에 update 수행하라
UPDATE tbl_score SC
SET s_sbcode = 
    (SELECT sb_code FROM tbl_subject SB 
    WHERE SC.s_subject = sb.sb_name);

-- UPDATE 후의 검증
SELECT sc.s_sbcode, sb.sb_code, sc.s_subject, sb.sb_name
FROM tbl_score SC, tbl_subject SB
WHERE sc.s_sbcode = sb.sb_code;

-- tbl_score의 s_subject 칼럼 삭제

ALTER TABLE tbl_score DROP COLUMN s_subject;

-- tbl_score s_sbcode 칼럼을 이름변경
ALTER TABLE tbl_score RENAME COLUMN s_sbcode TO s_subject;
DESC tbl_score;

-- 제2 정규화 완료
SELECT * FROM tbl_score;

-- JOIN을 통해서 데이터 확인
SELECT s_std,s_subject, sb.sb_name,sb.sb_pro,s_score
FROM tbl_score SC, tbl_subject SB
WHERE sc.s_subject= sb.sb_code;

-- TABLE JOIN 시 TABLE들의 칼럼 이름이 같은 이름이 존재할 때
-- 반드시 칼럼이 어떤 TABLE에 있는 칼럼인지 명시를 해주어야 문법적 오류가
-- 발생하지 않는다 
-- TABLE을 설계할 때 가급적 접두사를 붙여서 만드는 것이 좋으며
-- JOIN시 TABLE alias를 설정하여 alias.Clomn 형식으로 하는 것이 좋다

/*
 Table1 : num, name, addr, dept
 Table2 : num, subject, pro
 
 SELECT * FROM Table1, Table2
    WHERE dept = num;
    라는 형식으로 sql을 작성하면 num이 누구의 Table인지 알수 없어서
    문법적 오류가 발생한다
    
SELECT T1.num AS 학번, T1.name, T1.addr, T1.dept,
        T2.num AS 과목코드, T2.subject, T2.pro
FROM Table1 T1, Table2 T2
WHERE T1.dept = T2.num;
와 같은 형식으로 sql을 작성하는 것이 만약의 오류를 줄일 수 있다
*/

SELECT s_id,s_std,s_subject,s_score,s_rem
FROM tbl_score;

SELECT *
FROM tbl_score
WHERE s_id>600;

DELETE 
FROM tbl_score
WHERE s_id >600;

COMMIT;































