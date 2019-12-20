-- 여기는 USER3입니다

-- JOIN 보통 2개 이상의 테이블에 나뉘어서 보관중인 데이터를
-- 서로 연계해서 하나의 리스트처럼 출력하는 SQL명령형태

-- EQ JOIN 완전 조인 내부조인
-- 두테이블에 연계된 칼럼이 모두 존재할 경우
-- 두 테이블간의 완전 참조무결성이 보장되는 경우
-- 이 조인이 표시하는 리스트를 카티션곱이라한다

SELECT * FROM tbl_books B, tbl_genre G WHERE b.b_genre= g.g_code;

INSERT INTO tbl_books(b_isbn,b_title,b_comp,b_writer,b_genre)
VALUES('979-009','아침형인간','하늘소식','이몽룡','010');

SELECT * FROM tbl_books B, tbl_genre G WHERE b.b_genre= g.g_code;
-- 그 결과 EQ JOIN으로 확인해 보니 새로 등록한 도서리스트가 누락되어 출력됨
-- 이제 출력 결과는 신뢰성을 잃게 되었다

-- 이런 상황이 발생했을 경우
-- 참조무결성을 무시하고 신뢰성이 있는 리스트를 보기 위해서 다른 JOIN을 수행한다

-- LEFT JOIN
-- LEFT 에 있는 TABLE리스트는 모두 보여주고 ON 조건에 일치하는 값이 오른쪽의
-- TABLE에 존재할 경우 값을 보이고 일치하지 않을시 NULL로 표현
SELECT * FROM tbl_books B-- 확인하려는 TABLE
LEFT JOIN tbl_genre G      -- 참조할 TABLE
ON B.b_genre = G.g_code     -- 참조할 칼럼
ORDER BY B.b_isbn;         -- 도서 코드 순서로 정렬

--tbl_books table b_title 칼럼의 값이 '아침형인간'인 리스트를 보이되
-- 만약 b_genre 칼럼값과 일치하는 값이 tbl_genre의 g_code칼럼에 
-- 있을시 리스트에 보여주고 그렇지 않으면 (null)로 표현하라

SELECT * FROM tbl_books B 
LEFT JOIN tbl_genre G
ON B.b_genre = g.g_code
WHERE b.b_title = '아침형인간';

SELECT b.b_isbn,B.b_title,b.b_comp,b.b_writer,G.g_code,G.g_name
FROM tbl_books B 
LEFT JOIN tbl_genre G
ON B.b_genre = G.g_code
WHERE b.b_title LIKE 'SQL'
ORDER BY b.b_title;

SELECT b.b_isbn,B.b_title,b.b_comp,b.b_writer,G.g_code,G.g_name
FROM tbl_books B 
LEFT JOIN tbl_genre G
ON B.b_genre = G.g_code
WHERE g.g_name = '장편소설';


SELECT b.b_isbn,B.b_title,b.b_comp,b.b_writer,G.g_code,G.g_name
FROM tbl_books B 
LEFT JOIN tbl_genre G
ON B.b_genre = G.g_code;

-- 장르가 '장편소설'인 도서정보를 '장르소설' 변경
-- 테이블이 각각 books genre로 나뉘어 있고
-- 두테이블을 join해서 사용하는 중이기 때문에
-- tbl_genre테이블의 g_name칼럼 값을 변경한다
SELECT * FROM tbl_genre;
UPDATE tbl_genre
SET g_name = '장르 소설'
WHERE g_code = '003';


SELECT b.b_isbn,B.b_title,b.b_comp,b.b_writer,G.g_code,G.g_name
FROM tbl_books B 
LEFT JOIN tbl_genre G
ON B.b_genre = G.g_code;

-- tbl_books 리스트를 조회했더니 '장편소설'인 장르데이터가 3개가 있다
-- 만약 tbl_books 테이블에 장르칼럼을 이름으로 설정을 했더라면
-- 다음과 같은 업데이트문을 실행해야 할것이다

UPDATE tbl_books
SET b_genre = '장르 소설'
WHERE b_genre = '장편소설';


SELECT b.b_isbn,B.b_title,b.b_comp,b.b_writer,G.g_code,G.g_name
FROM tbl_books B 
LEFT JOIN tbl_genre G
ON B.b_genre = G.g_code;
