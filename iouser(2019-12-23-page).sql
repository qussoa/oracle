--iouser
-- pagination
/*
    pagination
     전체레코드를 모두 읽어서 화면에 보여주는 것은
     실제상화에서는 매우 비효율적이다
     메모리도 문제가 될수 있고, 메모리도 문제가 될 수 있으며
     성능면에서도 상당히 여러문제를 일으킨다
     
     적당한크기를 읽어드리고
     처리를 한 후
     더 많은 내용을 보고 싶으면
     더보기, 다른페이지를 선택해서 읽어 들이도록 SQL 수행
     
     MySQL : limit라는 속성으로 매우 편리하게 pagination을 구현
     msSQL ; offset limit라는 속성
     기타 DBMS : limit offset과 같은 개념들이 있어서 편하게 구현 가능
     
     오라클은 limit offset 등을 실제적으로 지원하지 않음
     오라클은 개발자, DBA가 limit등을 수행하지 않아도
     엔진자체에서 optimizer 기능이 있어서
     어느정도는 자체 커버가 된다
     실제 select * from [table]을 수행하더라도
     보통 200개 단뒤로 구분하여 fatch(읽어들이기)를 수행하는 기능이 있다
     
     select * from [table] order by를 사용할 경우 
     자체 엔진이 상당히 무리하게 작동한다
     하지만 오라클에서는 order by와 where절을 같이 사용하지만 않으면
     자체 opt엔진이 나름대로 방법으로 정렬을 수행한다
     
     오라클 pagination에서는
     정렬따로, where따로 만들어서 사용을 한다
     sub query를 사용하여 sql을 만든다
*/
select * from tbl_product;
/*
p_code 칼럼은 pk로 선언되어 있다
pk로 선언된 항목은 내부의 index가 자동으로 생성된 상태이다
그나마 pk를 상대로 order by를 수행하면 
다른 칼럼에 비해 성능이 나은 편이다 
*/
select * from tbl_product 
order by p_code;

-- 표준 sql을 사용한 내림차순 정렬 sql
select * from tbl_product order by p_code desc;
-- oracle의 Hint라는 기능을 사용하여
-- PK를 기준으로 내림차순 정렬한 SQL

-- 한줄 주석
/* 여러줄 주석 */

/*
    INDEX_DESC([table][index 이름])
    [index이름]으로 설정된 인덱스를 사용하여 내림차순 정렬한 후 보여달라
    FIRST_ROWS
    우선적으로 앞쪽에 있는 레코드들을 먼저 보여달라
    데이터가 많을 때 순서가 앞에 있는 레코드를 먼저 찾는 옵티마이저 
    알고리즘을 작동시켜라
*/
/* from에 테이블 대신 다른 select 쿼리를 사용한 sql 작성
   from절에 사용한 select를 inline view
   
   first rows
   where 절에서 rownum 가상 값을 n 이하로 설정하면
   처음부터 n까지 데이터를 가져오는데 최소 비용을 투입하는
   알고리즘을 작동하여라
*/

-- 사용자에게 입력받아서 테스트하는 코드
-- &변수를 사용하면 쿼리 실행에서 입력창이 나타나서 값을 
-- 입력할 수 있다

/*
 first_rows
 9i이하에서는 cost base로 옵티마이저 실행
 10 이상에서는 index base 옵티마이저 실행을 해서
 tabled에 index가 없거나 레코드의 개수가 현저히 적으면 오히려
 옵티마이저를 하지 않은 것보다 늦게 나오는 경우가 있다
 
 FIRST_ROWS(정수) 옵티마이저를 제한
 10이상에서는
 FIRST_ROWS_10 FIRST_ROWS_100, FIRST_ROWS_100000 형식으로 작성해야
 좀 더 효율적으로 작동이 된다
*/
select * from
(
select /*+  FIRST_ROWS*/ROWNUM as num, ip.* from
(
select /*+ index_desc(p) */ * from tbl_product p -- inline view
) ip
where rowNUM <= &last_no
) tbl
where num >= &first_no;

-- first_rows hint는 무조건 table 첫번째 레코드부터
-- 최적화 알고리즘을 작동시키도록 구조가 만들어져 있어서
-- 시작값을 where로 제한하면
-- first_rows는 작동하지 않는다

select /*+  FIRST_ROWS*/ROWNUM as num, ip.* from
(
select /*+ index_desc(p) */ * from tbl_product p -- inline view
) ip
where rownum BETWEEN 91 and 100;








