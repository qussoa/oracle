SELECT * FROM tbl_books;

/*
PRIMARY KEY
DBMS 객체 무결성을 보장하기 위해 사용하는 중요한 요소
객체 무결성
    1. 내가 어떤 데이터를 조회했을때 나타나는 
      데이터는 내가 필요로한 데이터이다라는 보장
    2. PK를 WHERE 조건으로 SELECT를 했을때 나타나는 데이터는 1개의 레코드이며
      이 데이터는 내가 원하는 데이터이다라는 보장
      
    3. PK는 1개의 칼럼을 지정하는 것이 원칙이지만 실제 상황에서 1개의 칼럼만으로 PK를
      지정하지 못하는 경우가 있다. 이럴때는 2개 이상의 복수 칼럼을 묶어서 PK로 지정하는
      경우도 있다
      EX) 거래처정보
        거래명 + 대표+ 전화번호 칼럼을 묶어서 PK로 지정하는 경우
    
    4. 복수의 칼럼을 PK로 지정하는 경우
        UPDATE DELETE를 수행할때 PK를 WHERE 조건으로 명령을 수행할때
        상당히 번잡한 SQL을 구성해야 하는 경우도 있다
        EX) DELETE FROM[거래처정보]
        WHERE 거래명 = '거래처명' AND 대표 = '대표' AND 전화번호 = '전화번호'
        
    5. 가급적이면 1개의 칼럼을 PK로 지정하는 것이 좋고
        정말 PK로 지정할 칼럼을 선택할 수 없을때는 실제 존재하는 데이터가 아닌
        새로운 칼럼을 하나 추가하고 그 칼럼을 PK로 설정하는 방법도 있다
        EX) '코드','ID'와 같은 칼럼을 추가해서 사용한다
    
    6. '코드'칼럼은 최초 데이터를 추가하기 위해 준비단계에서 일정한 조건으로 만들어서
        사용하는 경우가 많기 때문에 특별히 어려움이 발생하지는 않지만 'ID' 칼럼은
        실제 데이터와 관계없이 '일련번호','SN' 형식으로 지정하는 경우도 많다 
        'ID'칼럼은 보편적인 DBMS에서는 최대 자리수를 갖는 숫자형으로 지정하고 해당
        칼럼의 AUTO INCREMENT 라는 옵션을 지정하여 INSERT를 수행할때마다 자동으로
        새로운 숫자 값이 생성되도록 할 수 있으나 오라클 11이하에서는 AUTO INCREMENT
        옵션이 없어 여러가지 방법으로 사용한다
        그 중 가장 많이 사용하는 방법중 하나는 SEQUENCE OBJECT를 생성하고 SEQUENCE의
        NEXTVAL 값을 활용하여 데이터를 추가할 때 ID 칼럼에 새로운 값이 만들어져 저장되도록
        사용한다
        
        오라클의 SEQ는 한번 생성하면 현재상태를 영구 보관하고 있다 언제든 NEXTVAL 호출시
        현재상태 + (INCREMENT BY로 저장한 만큼) 연산을 수행하여 새로운 값을 만들어 낸다
        
*/

/*

    오라클에서 RANDOM, SEQ외에 사용할 수 있는 PK값 생성하기
    GUID
    GRLOBAL UNIQUE IDENTIFIED
    범 우주적 유일한 값
    
    32BYTE의 중복되지 않는 키값 설정
    041664A556B64104B79490F7E8D803B5
    
    오라클에서는 
    GUID를 저장할 칼럼의 데이터 형식을 RAW(크기 제한이 없는 무한의 바이너리 형태)값으로 
    지정하거나  nVARCHAR2(125) 이상으로 지정해서 사용한다
*/

SELECT SYS_GUID() FROM DUAL;

INSERT INTO tbl_books(b_code,b_name)
VALUES(SYS_GUID(),'GUID 연습');

/*
INDEX
자주 SELECT를 수행하는 칼럼이 있을 경우 해당 칼럼을 INDEX라는 OBJECT로 생성을 
해주면 SELECT를 수행할때 INDEX를 먼저 조회하고 INDEX로부터 해당 데이터가 
저장된 레코드에 주소를 얻은 것을 통해서 TABLE로부터 데이터를 가져와 SELECT(조회) 
수행 속도 효율을 높이는 기법

table을 생성할때 PK로 지정하면 PK칼럼은 기본적으로 index로 설정된다
*/

-- b_name 칼럼을 별도로 index로 지정하겠다
CREATE INDEX IDX_NAME ON tbl_books(b_name);
SELECT * FROM tbl_books WHERE b_name = 'SEQ연습';
-- DBMS 업무중에 b_name(도서명)과 b_writer(저자)를 조건으로 하는 SELECT문을
-- 자주 수행한다면
SELECT * FROM tbl_books WHERE b_name = '자바' AND b_writer = '홍길동';
CREATE INDEX IDX_NAME_WRITER ON tbl_books(b_name, b_writer);

DROP INDEX IDX_NAME_WRITER;

/*
    INDEX는 SELECT를 실행하는 매우 효율적으로 작동되는 구조이나 
    개발 초기 많은 양의 데이터를 INSERT를 수행해야할 경우
    INDEX를 설정하지 않고 사용하는 것이 효율적이다
    
    초기 데이터를 추가할 시 가급적 PK로 설정된 칼럼을 기준으로 정렬된
    원본 데이터로 INSERT를 수행하는 것이 효율적이다
    
    INDEX를 필요이상으로 너무 많이 설정하면 INSERT UPDATE DELETE를 수행할시
    매우 비효율적으로 작동될 수 있으며 INDEX OBJECT가 문제를 야기시키는 상황도
    생길 수 있다 
*/

DROP INDEX IDX_NAME;

-- UPDATE INDEX
-- 마치 TABLE을 생성할 떄 해당하는 칼럼에 UNIQUE 제약조건을 설정한 것처럼 작동된다
-- 기존에 저장되어 있는 데이터가 UNIQUE상태가 아니면 인덱스가 생성되지 않는다

CREATE UNIQUE INDEX IDX_NAME ON tbl_books(b_name);
-- index가 손상된 것 같다 drop 후 create 생성
-- 상용 dbms에서는 index 손상되면 dbms 자체적으로 rebuild하는 기능이 포함되어 있다





