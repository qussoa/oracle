-- 주석문 마크다
-- 명령문이 끝나는 ;을 붙여야한다;
-- 대소문자 관계없다
-- keyword는 모두 대문자 작성
-- keyword가 아닌 경우는 소문자로 작성

-- 문자열이나 특별한 경우는 대소문자를 구별하는 경우도 있다
-- -> 대소문자 구분을 공지

SELECT 30 + 40 FROM dual ;
select 40 * 30 from dual;

-- 데이터를 조회(SELECT)할 때 ','로 구분을 하면
-- TABLE로 보여줄때 Column으로 구분하여 보여준다
SELECT 30 + 40 , 30*40, 40/2, 50-10 FROM dual ;

-- 문자열은 작은따옴표(SQ,') 묶어준다
SELECT '대한민국' FROM dual;

-- 문자열을 연결하여 보여줄때는 || 로 이어준다
SELECT '대한'||'민국' FROM dual;
SELECT '대한','민국','만세','KOREA' FROM dual;

-- 조회할 때 SELECT * FROM 명령문을 사용하면 
-- 모든것을 보여달라는 표시다
SELECT * FROM dual;

SELECT * FROM v$database; 



