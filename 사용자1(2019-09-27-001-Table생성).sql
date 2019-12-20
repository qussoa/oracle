-- 여기는 user1 사용자 화면입니다
-- DBA 역할 중에서
-- 데이터 저장소의 기초인 Table을 만드는 것

-- 오늘은 학생정보를 저장할 tbl_student table 생성

-- tbl_student 라는 이름으로  table (물리적 저장소)를 생성한다
-- tbl_student : 생성할 table 이름
-- 이름명명규칙 : java에서 변수, 클래스, method 등의 이름을 명명하는
-- 것과 같으나 오라클에서는 대소문자를 구별하지 않는다 
-- table 명명 패턴 : 일반적으로 table 만들때 테이블 이름 앞에 접두사로 tbl_ 를 사용한다
-- 

CREATE TABLE tbl_student(
    -- 칼럼 : 필드(멤버)변수 같은 개념
    -- 칼럼들은 컴마(,)로 구변하여 나열한다
    -- 칼럼들의 data type을 지정
    -- data type에는 () 사용하여 최대 저장할 크기를 byte단위로 지정
    -- CHAR () : 고정길이 문자열 저장 칼럼 
    --  저장할 데이터가 항상 일정한 길이를 갖고 있음이 보장될 경우
    --  최대 2000글자까지 지정
    -- 오라클에서 CHAR칼럼 순수 숫자로만 되어 있는 데이터를 저장할 경우
    -- 약간 문제를 일으킨다
    -- A0001 형식으로 저장하면 당연히 문자열로 인식한다
    -- 0001 형식으로 저장하면 오라클DB에-는 문자열로 저장이 되는데
    --      JAVA(또는 프로그래밍언어)를 통해서 DB에 접속을 할 경우 
    --      숫조로 인식을 해버리는 오류가 있다
    -- 그래서 오라클에서는 아주 특별한 경우가 아닐 경우 VARCHAR2로 사용한다
    st_num CHAR (5),
    
    -- VARCHAR2(): 가변길이 문자열 저장 칼럼
    -- 최대 4000글자까지 저장
    -- 최대글자까지 저장하는 것은 CHAR와 유사하지만
    -- 만약 저장하는 데이터의 길이가 일정하지 않을 경우는
    -- 데이터 길이만큼 칼럼이 변환되어 파일에 저장된다
    
    -- nVARCHAR2() : 유니코드 다국어 지원 칼럼
    -- 만약 한글 데이터가 입력될 가능성이 있는 칼럼은
    -- 반드시 nVARCHAR2() 사용하자 
    -- 한글이 입력될 가능성이 하나도 없으면
    -- VARCHAR2() 사용하지만 nVARCHAR2를 사용해도 괜찮다
    st_name nVARCHAR2 (20),
    st_addr nVARCHAR2 (125),
    
    
    st_tel VARCHAR2 (20),
    
    -- 숫자를 저장할 칼럼
    -- 표준 SQL에서 INT, FIOAT, LONG, DOUBLE 등의 keyword 가 있다
    -- 오라클에서도 표준 SQL 숫자 type를 사용할 수 있지만
    -- 오라클 코드에서는 NUMBER라는 칼럼을 사용한다
    st_grade NUMBER (1),
    st_dept nVARCHAR2 (10),
    st_age NUMBER(3)    -- 마지막 칼럼뒤에는 컴마를 쓰지 않는다
);

INSERT INTO tbl_student(st_num,st_name,st_addr)
VALUES('0001','성춘향','익산시');
INSERT INTO tbl_student(st_num,st_name,st_addr)
VALUES('0002','성춘향','남원시');
SELECT * FROM tbl_student dual;

DROP TABLE tbl_student;
-- 시나리오
-- tbl_student에 많은 학생의 데이터를 추가하다보니
-- 학번이 0100인 학생의 데이터가 2번 추가가 되었다
-- 이후에 tbl_student 테이블에서 0100의 학생데이터를 조회했더니
-- 데이터가 2개가 조회되었다
-- 이런 상황이 되면 0100 학생의 데이터 2개중 어떤 데이터가 
-- 이 학생의 데이터인지 알기가 매우 어려워진다
-- 여러가지 데이터를 다시 검증해야만 어떤 데이터가 정상적(사용할 수 있는)인
-- 데이터인지 확인할 수 있다

-- 이런 문제가 발생하지 않도록 조치를 취해줘야한다
-- DB에서는 이런문제가 발생하지 않기 위해 "제약조건" 설정이 있다

-- tbl_student table 에는 절대 학번이 동일한 데이터가 2개 이상없어야한다
-- 라는 제약 조건을 설정해줘야한다

-- UNIQUE 제약조건이라고 한다

CREATE TABLE tbl_student(
    
    st_num  CHAR(5) UNIQUE,
    st_name nVARCHAR2(20) ,
    st_addr  nVARCHAR2(125),
    st_tel    VARCHAR2(20),
    st_dept  nVARCHAR2(20),
    st_grade NUMBER(1),
    st_age   NUMBER(3)
    
    
);

INSERT INTO tbl_student(st_num,st_name,st_addr)
VALUES('00001','성춘향','남원시');


-- 많은 양의 데이터를 입력하는 과정에서
-- 실수로 학번 10001 학생을 추가해야하는데
-- 학번을 00001로 하여 추가하는 코드를 작성 실행했다

INSERT INTO tbl_student(st_num,st_name,st_addr)
VALUES('00001','이몽룡','서울시');

-- 오라클에서 ORA-00001: unique constraint (USER1.SYS_C006997) violated
-- 오류 메세지 중 "unique constraint"가 포함되면
-- UNIQUE로 설정된 칼럼에 이미 존재하는 값을 추가하려고 했다는 뜻
-- UNIQUE 중복배제, 중복금지
INSERT INTO tbl_student(st_num,st_tel)
VALUES('20111','010-1111-0000');
SELECT * FROM tbl_student dual;

DROP TABLE tbl_student;

-- 데이터를 추가하는 과정에서 
-- 학번은 위에서 중복금지 제약조건을 설정하여
-- 중복된 값이 추가되지 못하도록 설정을 했다

-- 많은 양의 데이터를 추가하다보니
-- 실수로 학생이름, 전화번호 등을 입력하지 않고 추가한 데이터들이 존재한다
-- 나중에  tbl_student 테이블의 데이터를 사용하여 업무를 수행하려 했더니
-- 이름, 전화번호가 없어서 상당히 문제를 일으킨다

-- 이러한 일들을 방지하기 위해 값이 없는 칼럼이 존재하면 안되는 데이터들이 
-- 추가되는 것을 방지하기 위해 꼭 있어야하는 칼럼에 NOT NULL 제약 조건을 설정한다

-- NOT NULL 제약조건이 설정된 칼럼은
-- 데이터를 추가할 때 반드시 같이 있어야한다
CREATE TABLE tbl_student(
    
    st_num  CHAR(5) UNIQUE NOT NULL,
    st_name nVARCHAR2(20)  NOT NULL,
    st_addr  nVARCHAR2(125) ,
    st_tel    VARCHAR2(20) NOT NULL,
    st_dept  nVARCHAR2(20),
    st_grade NUMBER(1),
    st_age   NUMBER(3)
);

-- 데이터를 추가하는 과정에서 학번, 전화번호만 데이터를 입력하고 
-- 이름은 없는 상태로 데이터를 추가하려고 명령을 실행하면 
-- ORA-01400: cannot insert NULL into ("USER1"."TBL_STUDENT"."ST_NAME")
-- 라는 오류가 발생한다 
INSERT INTO tbl_student(st_num,st_name,st_addr)
VALUES('00001','성춘향','남원시');
INSERT INTO tbl_student(st_num,st_name,st_tel)
VALUES('20111','이몽룡','010-1111-0000');
SELECT * FROM tbl_student dual;

-- tbl_student 테이블은 학생정보를 보관하는 매우 중요한 table이다 
-- tbl_student에서 어떤 학생의 데이터를 조회하고자 할때
-- 학생이름, 전화번호, 등으로 조회를 할 수 있다
-- 하지만 학생이름이나 전화번호로 조회를 하면 추출되는 
-- 데이터가 2개 이상 보일 수 있다
-- 2개 이상의 데이터가 보이면 어떤 데이터가 내가 필요한 데이터인지
-- 다른 항목을 통해서 살펴봐야하는 불편함이 있다
-- 어떤 칼럼의 값을 조회했을 떄 유일하게 1개의 데이터만 추출되도록 설정할 수 있는데
-- 이런 설정을 한 칼럼을 기본키(primary key)라고 한다

-- tbl_student 테이블에 저장된 수많은 데이터중에서 st_num 값을 조회하면
-- 추출되는 데이터는 1개만 나타날 것이다
-- 이유는 현재 st_num 칼럼이 UNIQUE로 설정되어 있기 때문이다
-- 또한 st_num값을 조회했을떄
-- 추출되는 데이터는 없거나 1개만 나타난다

-- 이러한 조건을 만족하기 위해서 st_num 칼럼은 UNIQUE NOT NULL 제약조건을 설정해 준다
-- 더불어 st_num 칼럼은 PK라는 조건을 설정한다
-- PRIMARY KEY로 설정한 칼럼은 UNIQUE와 NOT NULL 조건을 만족하며
-- 더해 KEY로서 조회를 할때 매우 빨리 값을 조회할 수 있도록 DBMS가 별도 관리를 한다
-- PRIMARY KEY 로 설정한 칼럼은 UNIQUE와 NOT NULL 설정을 생략한다
DROP TABLE tbl_student;

CREATE TABLE tbl_student(
    
    st_num  CHAR(5) PRIMARY KEY, -- UNIQUE NOT NULL,
    st_name nVARCHAR2(20)  NOT NULL,
    st_addr  nVARCHAR2(125) ,
    st_tel    VARCHAR2(20) NOT NULL,
    st_dept  nVARCHAR2(20),
    st_grade NUMBER(1),
    st_age   NUMBER(3)
);

-- st_num는 PK로 설정되어있기 때문에
-- st_num의 값으로 조회를 하면 없거나 1개의 데이터만 보여준다

DESCRIBE tbl_student;
DESC tbl_student;

-- user1 사용자가 생성한 테이블이 어떤 것들이 잇는지 보여달라
SELECT * FROM dba_tables 
WHERE owner = 'USER1';

-- tbl-student 데이터 추가하기
-- INSERT INTO [table]([colum]
INSERT INTO tbl_student(st_num, st_name, st_tel, st_addr, st_dept, st_age)
VALUES('00001','홍길동','010-1111-1234','서울시','컴공과','33');
INSERT INTO tbl_student(st_num, st_name, st_tel, st_addr, st_dept, st_age)
VALUES('00002','이몽룡','010-1121-1234','익산시','문헌과','28');
INSERT INTO tbl_student(st_num, st_name, st_tel, st_addr, st_dept, st_age)
VALUES('00003','성춘향','010-1131-1234','남원시','예술과','18');
INSERT INTO tbl_student(st_num, st_name, st_tel, st_addr, st_dept, st_age)
VALUES('00004','장보고','010-5111-1234','해남군','컴공과','33');
INSERT INTO tbl_student(st_num, st_name, st_tel, st_addr, st_dept, st_age)
VALUES('00005','임꺽정','010-6111-1234','함경도','컴공과','33');
SELECT * FROM tbl_student dual;



