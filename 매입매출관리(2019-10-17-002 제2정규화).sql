-- 매입매출관리
-- 상품정보 제2정규화

-- 매입매출정보에 상품정보가 어떻게 저장되어 있는지 확인

SELECT io_Pname,DECODE(io_inout,1,io_price)
FROM tbl_iolist
WHERE DECODE(io_inout,1,io_price) IS NOT NULL
GROUP BY io_pname,DECODE(io_inout,1,io_price);

SELECT io_pname
FROM tbl_iolist
GROUP BY io_pname
ORDER BY io_pname;

-- 상품테이블 생성

CREATE TABLE tbl_product(

        p_code	VARCHAR2(6)	    NOT NULL	PRIMARY KEY,
        p_name	NVARCHAR2(50)	    NOT NULL	,
        p_iprice	NUMBER,
        p_oprice	NUMBER		
);

SELECT * FROM tbl_product;

-- 검증을 위해 tbl_iolist와 tbl_product를 EQ JOIN

SELECT io.io_inout, count(*)
FROM tbl_iolist IO, tbl_product P
WHERE io.io_pname = p.p_name
GROUP BY io.io_inout;

-- 상품테이블의 단가를 어떻게 세팅을 할 것인가

SELECT io.io_inout, io.io_pname, io.io_price, COUNT(*)
FROM tbl_iolist IO, tbl_product P
WHERE io.io_pname = p.p_name
    AND io.io_inout =1
GROUP BY io.io_inout, io.io_pname,io.io_price;

-- 매입매출 테이블에서 매입단가를 조회했더니 
-- 다행이 상품이름은 중복이나 단가가 다른 상품이 없다
-- 매입매출 테이블에서 매입단가를 상품정보테이블의 매입단가 칼럼에
-- 세팅을 하려고 한다

UPDATE tbl_product P
SET p_iprice 
=(
    SELECT MAX( IO.io_price)  
    FROM tbl_iolist IO
    WHERE io_inout =1 AND
        P.p_name = IO.io_pname
);

UPDATE tbl_product P
SET p_oprice 
=(
    SELECT MAX( IO.io_price)  
    FROM tbl_iolist IO
    WHERE io_inout =2 AND
        P.p_name = IO.io_pname
);

SELECT * FROM tbl_product;

-- 상품거래 정보에서 상품정보 매입 매출 단가를 생성했더니 
-- NULL인값이 있다
-- 한 상품에서 매입만 되고 어떤 상품은 매출만 된 경우

/*
     매입단가에서 매출단가 생성하기
     공산품일 경우  
     매출단가 = 매입단가 + (매입단가 *0,18*1.1) 
     
     매출단가에서 매입단가 생성하기
     매입단가 = (매출단가 /1.1)  - ((매출단가/1.1) *0.18)  
     매입단가 = (매출단가/1.1) * 0.82
*/

COMMIT ;

UPDATE tbl_product
SET p_iprice =
    (p_oprice/1.1)*0.82
WHERE p_iprice IS NULL;

UPDATE tbl_product
SET p_oprice =
    (p_iprice + (p_iprice*0.18)) * 1.1 
WHERE p_oprice IS NULL;

UPDATE tbl_product
SET p_iprice= ROUND(p_iprice,0),
     p_oprice= ROUND(p_oprice,0);

SELECT * FROM tbl_product;

ROLLBACK;
















