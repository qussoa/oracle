-- 여기는 user2 화면입니다 
-- UPDATE DELETE 명령어 연습

-- 새로운 사용자가 사용할 TABLE 생성
-- 주소록 TABLE 생성
-- 이름 , 전화번호, 주소, 관계 기타    생년월일 나이 
-- name, tel,       addr  chain remark birth     age
-- 한글  숫자      한글  한글 한글    숫자     숫자  
CREATE TABLE tbl_address(

    name nVARCHAR2(20) NOT NULL, -- 이름은 반드시 있어야 한다
    tel VARCHAR2(20) NOT NULL,     -- 전화번호도 반드시 있어야 한다
    addr NVARCHAR2(125),
    chain NVARCHAR2(10),
    remark NVARCHAR2(125),
    birth VARCHAR2(10),
    age NUMBER(3)

)

INSERT INTO tbl_address(name, tel)
VALUES('홍길동','서울틀별시');

SELECT * FROM tbl_address;


INSERT INTO tbl_address(name, tel)
VALUES('이몽룡','익산시');


INSERT INTO tbl_address(name, tel)
VALUES('성춘향','남원시');


INSERT INTO tbl_address(name, tel)
VALUES('장길산','부산시');


INSERT INTO tbl_address(name, tel)
VALUES('임꺽정','함경남도');

SELECT * FROM tbl_address;



COMMIT;

-- UPDATE
-- 이미 INSERT를 수행해서 TABLE에 보관중인 데이터의
-- 일부 칼럼의 값을 변경하는 것 

UPDATE tbl_address 
SET addr = '서울특별시';

SELECT * FROM tbl_address;

-- 데이터의 추가, 수장, 삭제 취소하는 명령
-- DCL 명령, TCL(Transaction Controll Lan,)
-- 이전에 COMMIT 을 수행한 이후
-- 데이터의 추가, 수정, 삭제를 수행한 것들을
-- 취소하는 명령
ROLLBACK;

SELECT *FROM tbl_address;

-- UPDATE 명령을 기본형으로 수행을 하게되면
-- 모든 RECORD 데이터가 변경이 되어 버리는 사태가 발생한다
-- 절대 UPDATE 명령은 기본형으로만 수행하지 말기

-- tbl_adress table 저장된 데이터들 중에서
-- name 칼럼의 값이 '홍길동' 인 데이터들을 찾아서
-- address  칼람의 값을 '서울특별시'fh qusrudgkfk
-- 일종의 변수 변경 밥법과 유사
UPDATE tbl_address
SET addr = '서울특별시'
WHERE name = '홍길동';
SELECT * from tbl_address;

UPDATE tbl_address
SET addr = '익산시'
WHERE name = '성춘향';


UPDATE tbl_address
SET addr = '남원시'
WHERE name = '이몽룡';

commit;

SELECT * from tbl_address;

-- 주소를 변경하고 봤더니
-- 이몽룡과 성춘향의 주소를 잘 못 변경한 것을 발견되었다
-- 이몽룡의 주소를 ' 남원시에서 '익산시'로 변경하고
-- 성춘향의 주소를 '익산시'에서 '남원시'로 변경

UPDATE tbl_address
SET addr = '익산시'
WHERE name = '이몽룡';

UPDATE tbl_address
SET addr = '남원시'
WHERE name = '성춘향';

COMMIT;

SELECT * from tbl_address;

INSERT INTO tbl_address(name, tel)
VALUES('홍길동','서울특별시');

SELECT * from tbl_address;

UPDATE tbl_address
SET addr = '광주광역시'
WHERE addr = '서울특별시';

SELECT * from tbl_address;

-- tbl_address 테이블을 생성해서 테스트를 해보니
-- 이름과 tel  칼럼의 값이 같은 경우에는
-- 어떤 1개의 데이터만 변경하려고 했을떄
-- 불가능에 가까운 상황에 맞딱드리게 되고 말았따
-- 현재 추가된 데이터에서
-- name tel 칼럼에 데이터만 가지고 있는데
-- 실수로 홍길동, 서울특별시 데이터가 2개가 추가가 되었다
-- 이 상황에서 홍길동 데이터 2개중 1개는 주소를 부산광역시로
-- 한개는 광주광역시로 바꾸고 싶을때 실행할수있는 방법이 없다
-- 결론적으로 이 table은 설계상 miss로 인해
--'개채무결성'이 훼손되었고 보강하기 위해서는 PK를 생성해야 하는데
-- 또한 현재 상황에서는 어려움이 있다
-- '개채무결성'을 보가하는  table을 재 설계하자
-- 지금 구상한 주소록 테이블에 저장된 값들은 중복되지 않는 칼럼을 찾을 수가 없다
-- 이럴때 별도 PK로 사용할 칼럼을 추가해서 '개채무결성'을 보장하는 방법이 있다
DROP TABLE tbl_address;

-- 기존 테이블을 삭제

CREATE TABLE tbl_address(

    id NUMBER PRIMARY KEY,
    name nVARCHAR2(20) NOT NULL, 
    tel VARCHAR2(20) NOT NULL,     
    addr NVARCHAR2(125),
    chain NVARCHAR2(10),
    remark NVARCHAR2(125),
    birth VARCHAR2(10),
    age NUMBER(3)

)


INSERT INTO tbl_address(id,name,tel)
VALUES(1,'홍길동','서울특별시');

INSERT INTO tbl_address(id,name,tel)
VALUES(2,'이몽룡','남원시');

INSERT INTO tbl_address(id,name,tel)
VALUES(3,'홍길동','서울특별시');

INSERT INTO tbl_address(id,name,tel)
VALUES(4,'홍길동','서울특별시');


INSERT INTO tbl_address(id,name,tel)
VALUES(5,'성춘향','익산시');

SELECT * from tbl_address;

-- 주소를 추가하고 보니
-- 전화번호 칼럼에- 주소를 입력하고
-- 더불어 서울특별시에 사는 홍길동의 데이터가 3개 중복 추가된 것을 확인했다
-- 원본 데이터를 봤더니
-- 홍길동이 동명이인으로 서울특별시, 광주광역시, 부산광역시에 거주하는것으로 확인되엇다
-- 한개의 홍길동 데이터는 그대로 두고
-- 한개는 주소를 광주광역시로, 나머지 한개는 주소를 부산광역시로 바꾸려한다
-- id가 1 홍길동 서울특별시 2 홍길동 광주광역시 3 홍길동 부산광역시


UPDATE tbl_address SET addr = '서울특별시' WHERE id = 1;
UPDATE tbl_address SET addr = '광주광역시' WHERE id = 3;
UPDATE tbl_address SET addr = '부산광역시' WHERE id = 4;

SELECT * from tbl_address;
COMMIT;

-- DELETE 명령도 UPDATE와 같이 기본형으로 실행 절대 ㄴㄴ

DELETE FROM tbl_address;
SELECT * from tbl_address;

-- 연습이기 때문에 ROLLBACK실행자

 ROLLBACK;
 SELECT * from tbl_address;
 
-- DELETE를 실행할때 TABLE PK가 있으면 반드시 PK단위로 데이터를 삭제하자
-- 1. 삭제하고자 하는 DATA가 있는지 여러 방법으로 조회를 해본다
SELECT *FROM tbl_address WHERE name ='성춘향';

DELETE FROM tbl_address WHERE name = '성춘향';

SELECT *FROM tbl_address WHERE name ='홍길동';
DELETE FROM tbl_address WHERE name = '홍길동';

SELECT *FROM tbl_address WHERE name = '홍길동' AND addr = '서울특별시';
DELETE FROM tbl_address WHERE name = '홍길동' AND addr = '서울특별시';

-- 2. 이름이 홍길동이고 주소가 서울특별시인 데이터를 삭제하려면
--    ID 값이 무엇인지 확인하고 
SELECT *FROM tbl_address WHERE name = '홍길동' AND addr = '서울특별시';
--3. ID를 조건으로하여 삭제 명령을 수행하자
DELETE FROM tbl_address WHERE id = 1;

-- 중요
-- UPDATE나 DELETE명령은 특별한 경우가 아니라면
-- 2개이상의 레코드에 대하여 동시에 적용되도록 명령을 수행하지 말자 
-- 번거럽고 불편하지만 PK칼럼을 WHERE 조건으로 하여 명령을 수행하자   

-- DBMS를 운영하는 과정에서
-- 만에 하나 재난(실수로 수행명령으로 데이터변경,삭제 천재지변)이 발생했을떄
-- 데이터를 복구할 수 있는 준비를 해야한다
-- 1. 백업 : 업무가 종료된 후 데이터를 다른 저장소, 저장매체에 복사하여 보관하는것
-- 1-1. 복구 : 백업해둔 데이터를 사용중인 시스템에 다시 설치하여 사용할 수 있도록 하는 것 
--           복구는 원상태로 만드는데 상당한 시간이 필요하고,
--           백업한 시점에 따라 완전복구가 되지 않는 경우도 있다 
-- 2. 로그 기록 복구 : INSERT, DELETE, UPDATE 명령이 수행할 때
--                    수행되는 모든 명령들을 별도의 파일로 기록해두고
--                    문제가 발생했을때 로그를 다시 역으로 추적하여 복구하는 방법 -> 저널링 복구
-- 3. 이중화, 삼중화 실제 운영중인 OS, DBMS, STORAGE 등을 똑같은 구조로
--    설치 위치를 달리하여 동시에 운영하는 것 
--    재난이 발생하면 발생 지역의 시스템을 단절하고 정상 시스텝ㅁ으로 절환하여 운영을 계속하도록 하는
--    시스템