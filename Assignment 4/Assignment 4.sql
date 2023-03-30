/* ______________________________________________
*/

/* 
Sanity test you are connected to the database by executing the 
following command from postgres server shell
*/

SELECT * FROM information_schema.tables
WHERE table_schema = 'public';


SELECT * FROM information_schema.columns
WHERE table_schema = 'public'
   AND table_name   = 'dwcustomer';
SELECT * FROM dwcustomer;
/*
cus_code - PK
cus_lname
cus_fname
cus_initial
cus_state
reg_id
*/


SELECT * FROM information_schema.columns
WHERE table_schema = 'public'
   AND table_name   = 'dwdaysalesfact';
SELECT * FROM dwdaysalesfact;
/*
tm_id - PK
cus_code - PK
p_code - PK
sale_units
sale_price
*/

SELECT * FROM information_schema.columns
WHERE table_schema = 'public'
   AND table_name   = 'dwproduct';
SELECT * FROM dwproduct;
/*
p_code - PK
p_descript
p_category
v_code - FK
*/

SELECT * FROM information_schema.columns
WHERE table_schema = 'public'
   AND table_name   = 'dwregion';
SELECT * FROM dwregion;
/*
reg_id - PK
reg_name
*/

SELECT * FROM information_schema.columns
WHERE table_schema = 'public'
   AND table_name   = 'dwtime';
SELECT * FROM dwtime;
/*
tm_id - PK
tm_year
tm_month
tm_day
tm_qtr
*/

SELECT * FROM information_schema.columns
WHERE table_schema = 'public'
   AND table_name   = 'dwvendor';
SELECT * FROM dwvendor;
/*
v_code - PK
v_name
v_areacode
v_state
*/

/*______________________________________________
*/

/*
1. Write and execute the SQL command to list the total sales 
by region and customer. 
Your output shoudl be sorted by region and customer
*/

SELECT REG_ID, S.CUS_CODE, SUM(SALE_UNITS*SALE_PRICE) AS TOTSALES
FROM DWDAYSALESFACT S 
JOIN DWCUSTOMER C ON S.CUS_CODE = C.CUS_CODE
GROUP BY REG_ID, S.CUS_CODE
ORDER BY REG_ID, S.CUS_CODE;


/*
2. Write and execute the SQL command to list the total sales 
by customer, month and product.
*/

SELECT t.TM_MONTH, p.p_code, C.CUS_CODE, SUM(S.SALE_UNITS*S.SALE_PRICE) AS TOTSALES
FROM DWDAYSALESFACT S 
JOIN DWCUSTOMER C ON S.CUS_CODE = C.CUS_CODE
JOIN dwtime t ON s.tm_id = t.tm_id
JOIN dwproduct p ON s.p_code = p.p_code
GROUP BY t.TM_MONTH, p.p_code, C.CUS_CODE;


/*
3. Write and execute the SQL command to list the total sales 
by customer and by product 
*/

SELECT p.p_code, C.CUS_CODE, SUM(S.SALE_UNITS*S.SALE_PRICE) AS TOTSALES
FROM DWDAYSALESFACT S 
JOIN DWCUSTOMER C ON S.CUS_CODE = C.CUS_CODE
JOIN dwproduct p ON s.p_code = p.p_code
GROUP BY p.p_code, C.CUS_CODE;


/*
4. Write and execute the SQL command to list the total sales 
by month and product category. Your output should be sorted by month and product category.
*/

SELECT TM_MONTH, P_CATEGORY, SUM(SALE_UNITS*SALE_PRICE) AS TOTSALES
FROM DWDAYSALESFACT S 
JOIN DWPRODUCT P ON S.P_CODE = P.P_CODE 
JOIN DWTIME T ON S.TM_ID = T.TM_ID
GROUP BY TM_MONTH, P_CATEGORY
ORDER BY  TM_MONTH, P_CATEGORY;


/*
5. Write and execute the SQL command to list the number of 
product sales (number of rows) and total sales by month.
Your output should be sorted by month.
*/

SELECT t.TM_MONTH, p.p_code, count(s.p_code) AS PRODSALES
FROM DWDAYSALESFACT S 
JOIN DWPRODUCT P ON S.P_CODE = P.P_CODE 
JOIN DWTIME T ON S.TM_ID = T.TM_ID
GROUP BY t.TM_MONTH, p.P_CODE
ORDER BY  t.TM_MONTH, p.p_code;


/*
6. Write and execute the SQL command to list the number of 
product sales (number of rows) and total sales by month 
and product category. 
Your output should be sorted by month and product category.
*/

SELECT t.TM_MONTH, p.P_CATEGORY, count(s.p_code) AS PRODSALES, 
SUM(s.SALE_UNITS*s.SALE_PRICE) AS TOTSALES
FROM DWDAYSALESFACT S 
JOIN DWPRODUCT P ON S.P_CODE = P.P_CODE 
JOIN DWTIME T ON S.TM_ID = T.TM_ID
GROUP BY t.TM_MONTH, p.P_CATEGORY
ORDER BY  t.TM_MONTH, p.P_CATEGORY;


/*
7. Write and execute the SQL command to list the number of 
product sales (number of rows) and total sales by month,
product category and product. 
Your output should be sorted by month, product category 
and product.
*/

SELECT t.TM_MONTH, p.P_CATEGORY, p.p_code, 
count(s.p_code) AS PRODSALES, 
SUM(s.SALE_UNITS*s.SALE_PRICE) AS TOTSALES
FROM DWDAYSALESFACT S 
JOIN DWPRODUCT P ON S.P_CODE = P.P_CODE 
JOIN DWTIME T ON S.TM_ID = T.TM_ID
GROUP BY t.TM_MONTH, p.P_CATEGORY, p.p_code
ORDER BY  t.TM_MONTH, p.P_CATEGORY, p.p_code;

