
1)
declare
  ename varchar(20);
  esal float;
  edept number;
  cursor c_emp is
    select emp_name, sal, dept_no from employee;
begin
open c_emp;
loop
fetch c_emp into ename, esal, edept;
  exit when c_emp%NOTFOUND;
  dbms_output.put_line(ename||' '||esal||' '||edept);
end loop;
close c_emp;
end;


2)
declare
  eid number;
  esal float;
  newsal float;
  cursor c_emp is
    select emp_no, sal from employee;
begin
open c_emp;
loop
  fetch c_emp into eid, esal;
  exit when c_emp%NOTFOUND;
  if esal<1200 then
    newsal:=1.08*esal;
  elsif esal<2500 then
    newsal:=1.12*esal;
  elsif esal<4500 then
    newsal:=1.15*esal;
  else
    newsal:=1.2*esal;
  end if;
  update employee set sal=newsal where emp_no=eid;
  dbms_output.put_line(esal||' changed to '||newsal);
end loop;
close c_emp;
end;


3)
declare
  edept number;
  erow employee%rowtype;
  cursor c_emp is
    select * from employee;
begin
edept:=&edept;
open c_emp;
loop
  fetch c_emp into erow;
  exit when c_emp%NOTFOUND;
  if erow.dept_no=edept then
    dbms_output.put_line(erow.emp_name||' '||erow.sal);
  end if;
end loop;
close c_emp;
end;
  
  
4)
declare
  cursor c_emp is
    select * from employee;
begin
for erow in c_emp loop
  dbms_output.put_line(erow.emp_name||' '||erow.sal||' '||erow.sal*0.12);
end loop;
end;


5)
create or replace procedure multiply(p in int, q in int, res out int) is
begin
res:=p*q;
end multiply;

declare
d int;
b int;
res int;
begin
d:=&d;
b:=&b;
for i in 1..b loop
multiply(d,i,res);
dbms_output.put_line(d||'*'||i||'='||res);
end loop;
end;


6)
create or replace procedure disp_emp
  (edept in number, sal_sum out float) is
  erow employee%rowtype;
  cursor c_emp is
    select * from employee where dept_no=edept;
begin
sal_sum:=0;
open c_emp;
loop
  fetch c_emp into erow;
  exit when c_emp%NOTFOUND;
  dbms_output.put_line(erow.emp_name||' '||erow.sal);
  sal_sum:=sal_sum+erow.sal;
end loop;
close c_emp;
end disp_emp;

declare
edept number;
esum float;
begin
edept:=&edept;
disp_emp(edept, esum);
dbms_output.put_line('Dept no '||edept||' has salary sum '||esum);
end;

7)
create or replace procedure raise_sal
  (eno in number, sal_enc in float) is
  esal float;
begin
select sal into esal from employee where emp_no=eno; 
update employee set sal=esal+sal_enc where emp_no=eno;
dbms_output.put_line(esal||' increased to '||esal+sal_enc);
end raise_sal;

declare 
  eno number;
  inc float;
begin
eno:=&eno;
inc:=&inc;
raise_sal(eno, inc);
end;


8)
create or replace function to_power
  (p int, q int) return int is
  res int;
begin
res:=1;
for i in 1..q loop
res:=res*p;
end loop;
return res;
end to_power;

declare
  b int;
  d int;
begin
b:=&b;
d:=&d;
dbms_output.put_line(to_power(b,d));
end;


9)
create table emp_dept(emp_name varchar2(20), dept_name varchar2(50));

create or replace trigger emp_trig
after insert on employee
for each row
declare
currdept varchar2(50);
begin
select dept_name into currdept from department where dept_no=:NEW.dept_no;
insert into emp_dept values(:NEW.emp_name, currdept);
dbms_output.put_line('Inserted '||:NEW.emp_name||' '||currdept);
end emp_trig;

insert into employee values('6', 'Akash', '7000', '2', '01-JAN-2016');


10)
create or replace trigger verify_join
before insert on employee
for each row
begin
if :NEW.join_dt>SYSDATE then
  RAISE_APPLICATION_ERROR(-20202, 'Invalid Date!');
end if;
end verify_join;

insert into employee values('7', 'Kaley', '8000', '3', '01-JAN-2019');

11)
create or replace trigger verify_insert
before insert on employee
for each row
begin
dbms_output.put_line('Inserting '||:NEW.emp_name);
end verify_insert;

insert into employee values('7', 'Kaley', '8000', '3', '01-JAN-2019');

