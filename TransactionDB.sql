create database TransactionsDB
use transactionsdb

create table employees(
emp_id int ,
emp_name varchar(50),
age int,
salary int
)
insert into employees values(101,'vamshi',26,25000),
(102,'sai',24,35000),
(104,'hari',27,25000)

----Auto_Commit


insert into employees values(103,'teja',24,26000);
update employees set salary=30000 where emp_id=101
delete employees where emp_id=104
select @@TRANCOUNT as trancount

select * from employees


---Implicit Transactions
set implicit_transactions on
insert into employees values(104,'venu',27,26000);
update employees set salary=30000 where emp_id=103
delete employees where emp_id=101
select @@TRANCOUNT as opentrans
commit
select @@TRANCOUNT as opentrans

----Explicit Transaction
begin transaction
insert into employees values(101,'vamshi',26,29000);
update employees set salary=30000 where emp_id=103
delete employees where emp_id=104
declare @ch int
set @ch=1;
if @ch=1
begin 
commit 
end
else begin
rollback
end

---Save Point---
begin transaction 

insert into employees values(104,'venu',27,28000);
save transaction deletepoint
delete employees where emp_id=101
delete employees where emp_id=102
delete employees where emp_id=103
rollback transaction deletepoint
commit

---------Locks in sql servers-------

-----ExclusiveLock(X)
begin transaction
update employees set salary=32000 where emp_id=103
rollback

---sharedLock(S)
set transaction isolation level repeatable read
begin tran
select * from employees
--rollback