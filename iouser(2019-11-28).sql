
drop table tbl_iolist;

CREATE VIEW view_iolist
as(
SELECT
IO_SEQ AS IO_SEQ,
IO_DATE AS IO_DATE,
IO_INOUT AS IO_INOUT,

IO_DCODE AS IO_DCODE,
D_NAME  AS IO_DNAME,
D_CEO   AS IO_DCEO,

IO_PCODE AS IO_PCODE,
P_NAME AS IO_PNAME,
P_IPRICE AS IO_IPRICE,
P_OPRICE AS IO_OPRICE,
P_VAT AS IO_VAT,

IO_QTY  AS IO_QTY,
IO_PRICE AS IO_PRICE,
IO_TOTAL AS IO_TOTAL

FROM tbl_iolist IO
     left join tbl_dept D
         on IO.io_Dcode = D.d_code
      left join tbl_product P
        on IO.io_pcode = P.p_code);
        
        select * from view_iolist;