SELECT *FROM tbl_address;

UPDATE tbl_address SET age = 33
WHERE id =5;


UPDATE tbl_address SET age = 0
WHERE id =4;

SELECT *FROM tbl_address;

-- tbl_address 테이블의 age 칼럼에 값이 입력되지 않는
-- 레코드들을 보여달라
SELECT *FROM tbl_address WHERE age IS NULL;

SELECT *FROM tbl_address
WHERE age IS NOT NULL;

-- 데이터 많이 추가를 한 후 혹시 중요한 칼럼의 데이터를 누락시키지 않았나를
-- 판별하고자 할때 사용하는 명령문

UPDATE tbl_address SET chain = ''
WHERE id = 3;

SELECT *FROM tbl_address;

-- ''(중간에 SPACE) 가 있는 문자열을 칼럼에 저장을 하면 
--(NULL) 기호가 사라지고 빈칸으로 보여진다
-- WHITE SPACE 라고 하며 실제로는 1개 이상의 SPACE 문자열이 저장되어있따

UPDATE tbl_address SET chain = ' '
WHERE id = 3;

SELECT *FROM tbl_address;

SELECT * FROM tbl_address WHERE addr IS NULL;
SELECT * FROM tbl_address WHERE addr IS NOT NULL;
SELECT * FROM tbl_address;

UPDATE tbl_address SET chain = '001' WHERE id = 1;
UPDATE tbl_address SET chain = '001' WHERE id = 2;
UPDATE tbl_address SET chain = '002' WHERE id = 3;
UPDATE tbl_address SET chain = '003' WHERE id = 4;
UPDATE tbl_address SET chain = '003' WHERE id = 5;

SELECT * FROM tbl_address;

-- 레코드 리스트를 확인했더니 chain 칼럼의 값들이 알 수없는 기호로 저장되었다
-- 현재는 001,002,003 기호값들이 무엇을 의미하는지 알 수가 없다
-- 001 가족 002 친구 003 이웃 으로 변경

SELECT id,name,addr,chain,
 DECODE(chain, '001','가족',
 DECODE(chain,'002','친구',
 DECODE(chain,'003','이웃'))) AS 관계
 FROM tbl_address;
 
 -- 이 SQL에서 만일 '관계' 항목에 (NULL)값이 존재한다는 것은
 -- CHAIN 칼럼에 값이 잘못 입력되었거나, 조건식이 잘못되었거나 한 경우
 
 
SELECT id,name,addr,chain,
 DECODE(chain, '001','가족',
 DECODE(chain,'002','친구',
 DECODE(chain,'003','이웃'))) AS 관계
 FROM tbl_address
 WHERE 
 DECODE(chain, '001','가족',
 DECODE(chain,'002','친구',
 DECODE(chain,'003','이웃'))) IS NULL;
 
 -- 테스트를 위해서 아래 SQL 문을 수행하면서
 -- CHAIN 칼럼에 값을 101 저장했다
 -- 그리고 위의 SELECT SQL 수행했더니
 -- 1개의 레코드가 보엿다
 -- 결국  CHAIN 칼럼에 데이터는 모두 (NULL) 값이 아닌 상태이어서
 -- 값이 저장은 되어잇지만
 -- 원하지 않은 값이 저장되어 있음을 알 수 있다
 -- 보기 위한 SQL 이기도 하지만, 데이터를 검증하는 도구로 활용되기도 한다
 INSERT INTO tbl_address (id,name,tel,chain)
 VALUES(6,'장보고','010-777-7777','101');
 
 SELECT * FROM tbl_address;
 
 -- 주소록 테이블에 저장된 모든 데이터를 아무런 조건없이 보여달라
 -- SELECT * projection을 *로 표현을 하면 모든 칼럼을 보여주는 형식인데
 -- 원하는 칼럼의 순서대로 보여진다는 보장이 없다
 -- 리스트를 보이는데 
 -- 보여지는 칼럼의 순서를
 -- id,
 -- 이름
 -- 전화번호
 -- 주소
 -- 관계
 -- 생년월일
 -- 나이 
 
 -- projetional 을 원하는 순서대로 보고자할 때
 -- SELECT 키워드에 칼럼리스트를 나열해주어야한다
 SELECT id,name,tel,addr,chain,birth,age
 FROM tbl_address;
 
 -- 경우에 따라 리스트를 보는데 모든 칼럼을 보이지 않고 몇몇 칼럼만 보고자 할때는
 -- 보고자 하는 칼럼들만 나열해주면 된다
 
 SELECT id,name,tel,chain
 FROM tbl_address;
 
 -- 데이터를 리스트에서 원하는 조건을 부여하여 
 -- 필요한 리스트만 확인하기
 -- 기본 SELECT FROM 명령어에 WHERE 조건절을 추가하여 사용한다
 
 SELECT * FROM tbl_address WHERE name = '홍길동';
 SELECT * FROM tbl_address WHERE name = '이몽룡';
 
 SELECT * FROM tbl_address;
 
 INSERT INTO tbl_address(id,name,tel)
 VALUES (10,'조덕배','010-1111-1111');
 
 INSERT INTO tbl_address(id,name,tel)
 VALUES (9,'조용필','010-2222-1222');
 
 INSERT INTO tbl_address(id,name,tel)
 VALUES (8,'양희은','010-1333-2221');
 
 SELECT * FROM tbl_address;
 
 -- 데이터를 조회할때 특정 칼럼을 기준으로 정렬을 수행하여
 -- 리스트를 보이기
 
 SELECT * FROM tbl_address
 ORDER BY name;
 
 
 SELECT * FROM tbl_address
 ORDER BY id;
 
 SELECT * FROM tbl_address
 ORDER BY name,addr;
 
 SELECT  * FROM tbl_address
 ORDER BY name DESC,addr ;
 
 SELECT * FROM tbl_address
 ORDER BY id,name,addr,tel,chain,remark,birth,age;
 
 -- 데이터를 추가하고 수정한 사항을 storage 저장(물리적 저장)하기위 해
 
 COMMIT;
  