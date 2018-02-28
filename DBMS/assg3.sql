set serveroutput on;

declare
b int;
d int;
total int;
avgg float;
begin
b:=&b;
d:=&d;
total:=b+d;
avgg:=total/2;
dbms_output.put_line(total||' '||avgg);
end;


declare
yr int;
begin
yr:=&yr;
if mod(yr,4)=0 and (mod(yr,100)<>0 or mod(yr,400)=0) then
  dbms_output.put_line('It is leap year');
  else
  dbms_output.put_line('It is not a leap year');
end if;
end;


declare
sal float;
wkexp int;
bonus float;
begin
sal:=&sal;
wkexp:=&wkexp;
bonus:=0.1*sal;
if wkexp > 10 then
  bonus:=bonus+500;
end if;
dbms_output.put_line('Bonus is: '||bonus);
end;


declare
sal float;
hra float;
da float;
netsal float;
begin
sal:=&sal;
if sal > 15000 then
  hra:=0.12*sal;
  da:=0.08*sal;
  elsif sal > 12000 then
  hra:=0.1*sal;
  da:=0.06*sal;
  elsif sal > 9000 then
  hra:=0.07*sal;
  da:=0.04*sal;
  else
  hra:=0.05*sal;
  da:=200;
end if;
netsal:=sal+hra+da;
dbms_output.put_line(hra||' '||da||' '||netsal);
end;

declare
prin int;
t int;
r int;
si int;
begin
prin:=&prin;
t:=&t;
if t > 10 then
  r:=8;
else
  r:=6;
end if;
si:=prin*r*t/100;
dbms_output.put_line(si);
end;


create table department(dept_no int, dept_name varchar(50), primary key(dept_no));
create table employee(emp_no int, emp_name varchar(20), sal float, dept_no int, foreign key(dept_no) references department(dept_no));

declare
eno int;
ename varchar(20);
esal float;
begin
eno:=&eno;
select emp_name, sal into ename, esal from employee where emp_no=eno;
dbms_output.put_line(ename||' '||esal);
end;


declare
ename varchar(20);
begin
select emp_name into ename from employee where sal=(select max(sal) from employee);
dbms_output.put_line(ename||' has maximum salary.');
select emp_name into ename from employee where sal=(select min(sal) from employee);
dbms_output.put_line(ename||' has minimum salary.');
end;


declare
eno int;
esal int;
begin
eno:=&eno;
select sal into esal from employee where emp_no=eno;
if esal<5000 then
  esal:=esal+0.1*esal;
  update employee set sal=esal where emp_no=eno;
  else
  delete from employee where emp_no=eno;
end if;
end;


declare
dno int;
begin
dno:=&dno;
delete from employee where dept_no=dno;
end;


declare
dno int;
dname varchar(50);
begin
dno:=&dno;
dname:=q'!&dname!';
insert into department values(dno, dname);
end;


declare
ename varchar(20);
esal float;
begin
esal:=&esal;
select emp_name into ename from employee where sal=esal;
dbms_output.put_line(ename);
exception
  when NO_DATA_FOUND then
  dbms_output.put_line('No data was found in table!');
  when TOO_MANY_ROWS then
  dbms_output.put_line('More than one row found!');
end;

declare
b float;
d float;
res float;
cust_exp exception;
begin
b:=&b;
d:=&d;
res:=b/d;
if b<d then
  raise cust_exp;
  else
  dbms_output.put_line(res);
end if;

exception
  when ZERO_DIVIDE then
  dbms_output.put_line('Divide by zero!!!');
  when cust_exp then
  dbms_output.put_line('Second number is greater than first!');
end;