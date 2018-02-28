  CREATE TABLE SalesPerson(SalesPersonNumber number(5), SalesPersonName varchar(20), CommPercentage number(3), YearHire number(4), OfficeNumber number(10)); 
  CREATE TABLE Customer(CustomerNumber number(5), CustomerName varchar(20), SalesPersonNumber number(5), HeadQuarterCity varchar(20));
  CREATE TABLE CustomerEmployee(CustomerNumber number(5), EmployeeNumber number(5), EmployeeName varchar(20), Title varchar(20));
  CREATE TABLE Product(ProductNumber number(5), ProductName varchar(20), UnitPrice number(5));
  CREATE TABLE Sales(SalesPersonNumber number(5), ProductNumber number(5), Quantity number(3));
  CREATE TABLE Office(OfficeNumber number(5), Telephone number(10), Size1 number(3));
  
  INSERT INTO salesperson VALUES('&SalesPersonNumber', '&SalesPersonName', '&CommPercentage', '&YearHire' , '&OfficeNumber');
  SELECT COMMPERCENTAGE, YEARHIRE FROM salesperson WHERE salespersonnumber=186;
  
  SELECT SALESPERSONNUMBER, SALESPERSONNAME FROM salesperson WHERE SALESPERSON.commpercentage=10;
  
  SELECT SALESPERSONNUMBER, SALESPERSONNAME FROM salesperson;
  
  SELECT SALESPERSONNUMBER, SALESPERSONNAME, COMMPERCENTAGE FROM salesperson WHERE SALESPERSON.commpercentage<12;
  
  SELECT CUSTOMERNUMBER, HEADQUARTERCITY FROM customer WHERE CUSTOMER.customernumber>1700;
  
  SELECT CUSTOMERNUMBER, CUSTOMERNAME, HEADQUARTERCITY FROM customer WHERE CUSTOMER.headquartercity='New York' AND CUSTOMER.customernumber>1500;
  
  SELECT CUSTOMERNUMBER, CUSTOMERNAME, HEADQUARTERCITY FROM customer WHERE CUSTOMER.headquartercity='New York' OR CUSTOMER.customernumber>1500;
  
  SELECT CUSTOMERNUMBER, CUSTOMERNAME, HEADQUARTERCITY FROM customer WHERE CUSTOMER.headquartercity='New York' OR (CUSTOMER.customernumber>1500 AND CUSTOMER.headquartercity='Atlanta');

  SELECT DISTINCT(HEADQUARTERCITY) FROM CUSTOMER;
  
  SELECT CUSTOMERNUMBER, HEADQUARTERCITY FROM customer WHERE CUSTOMER.customernumber>1000 ORDER BY CUSTOMER.headquartercity ASC;
  
  SELECT AVG(QUANTITY) FROM SALES WHERE salespersonnumber=137;
  
  SELECT MAX(QUANTITY) FROM sales WHERE productnumber=21765;
  
  SELECT COUNT(DISTINCT SALESPERSONNUMBER) FROM SALES WHERE productnumber=21765;
  
  SELECT SALESPERSONNUMBER, SUM(QUANTITY) FROM SALES
  GROUP BY salespersonnumber;
  
  SELECT SALESPERSONNUMBER, SUM(QUANTITY) FROM SALES
  GROUP BY salespersonnumber
  HAVING salespersonnumber>150;
  
  SELECT SALESPERSONNUMBER, SUM(QUANTITY) FROM SALES
  GROUP BY salespersonnumber
  HAVING (salespersonnumber>150 AND SUM(QUANTITY)>5000); 
  
  SELECT SALESPERSONNAME FROM salesperson, customer WHERE salesperson.salespersonnumber = customer.salespersonnumber AND customer.customernumber = 1525;
  
  SELECT ProductName FROM salesperson, sales, product 
  WHERE salesperson.salespersonname = 'Adam' AND sales.salespersonnumber = salesperson.salespersonnumber AND Product.productnumber = sales.productnumber AND sales.quantity > 2000;
  
  SELECT salesperson.SALESPERSONNUMBER FROM salesperson WHERE commpercentage=(SELECT MIN(commpercentage) FROM salesperson 
  WHERE salespersonnumber > 200) AND salespersonnumber > 200;