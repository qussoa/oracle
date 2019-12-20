-- 여기는 user1화면입니다
-- TABLE 생성 연습

CREATE TABLE tbl_addr(

    -- 이름, 주소, 전화번호, 나이, 관계
    name     VARCHAR2(10), -- String 
    addr      VARCHAR2(125),  -- String 
    tel        VARCHAR2(20),   -- String
    age       INT,   -- int
    chain     VARCHAR2(20)  -- String
);
SELECT *FROM tbl_addr;
INSERT INTO tbl_addr (name,addr,tel,age,chain)
VALUES('홍길동','서울시','010-1111-1111',33,'친구');

SELECT * FROM tbl_addr;
UPDATE tbl_addr
SET addr = '광주광역시';

SELECT * FROM tbl_addr;
DELETE FROM tbl_addr;
SELECT * FROM tbl_addr;

 
 
  
  
   
