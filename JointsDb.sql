create database JointsDb
use JointsDb
create table employee(
Emp_id int identity primary key,
emp_name varchar(20) not null,
salary int not null,
dep_id varchar(20)not null,
manager_id varchar(20)

);
select * from employee

insert into employee values ('rohith',30000,'D2','M2'),
('sai',40000,'D3','M3'),
('vamshi',45000,'D4','M4'),
('teja',30000,'D5','M5'),
('swathi',35000,'D6','M6')

create table departments(
dep_id varchar(20),
dep_name varchar(40)
);

insert into departments values('D1','Hr'),
('D2','Developer'),
('D3','Tester'),
('D4','Admin')

select * from departments

create table manager (
manager_id varchar(20),
manager_name varchar(40),
dep_id varchar(20)
)

insert into manager values ('M5','Naveen','D3'),
('M2','Nagesh','D4'),
('M3','Sheela','D1'),
('M4','sri','D1')

create table projects (
projaec_id varchar (20),
project_name varchar(20),
team_member_id varchar(20)
)
alter table projects 
alter column team_member_id character varying(20)


insert into projects values('p1','Data migration',1),
('p2','Data migration',2),
('p3','Googlemap',''),
('p4','Googlemap','')

select * from projects
update projects 
set team_member_id=1
where projaec_id='P3'

update projects 
set team_member_id=4
where projaec_id='P4'

Select * from projects

create table company(
comp_id int,
company_name varchar(20),
compant_location varchar(20)
)
insert into company values (1001,'BridgeLabz','Mumbai')

create table family (
member_id varchar(20),
name varchar(40),
age int,
parent_id varchar(20)
)
insert into family values ('F1','david',4,'F5'),
('F2','carol',10,'F5'),
('F3','michel',12,'F5'),
--('F4','jhonson',36),
('F5','mariam',43,'F6'),
--('F6','stev',70),
('F7','rohan',6,'F4'),
('F8','asta',8,'F4')


--fetch employee name and department using joints
--inner joint or joint

select e.emp_name,d.dep_name
from employee e
inner join departments d on e.dep_id=d.dep_id


--fetch all names and departments
--left joint

select e.emp_name,d.dep_name
from employee e
left join departments d on e.dep_id=d.dep_id

--fetch all names and departments
--right joint

select e.emp_name,d.dep_name
from employee e
right join departments d on e.dep_id=d.dep_id


--fetch all emp-name,departmrnt,manager,project using joints

select e.emp_name,d.dep_name,m.manager_name,p.project_name
from employee e
left join departments d on e.dep_id=d.dep_id
inner join manager m on m.manager_id=e.manager_id
join projects p on p.team_member_id=e.Emp_id


select * from employee
select * from departments
select * from manager
select * from projects
---


-----full joint or full outer joint---

select e.emp_name,d.dep_name
from employee e
full join departments d on e.dep_id=d.dep_id


----cross joint ---it returns cartesian

select e.emp_name,d.dep_name
from employee e
cross join departments d



---fetch company name to employees using cross join
select e.emp_name,d.dep_name,c.company_name,c.compant_location
from employee e
inner join departments d on e.dep_id=d.dep_id
cross join company c


--self join 

select
child.name as child_name,child.age as child_age,
parent.name as parent_name,parent.age as parent_age
from family as child
 join family as parent on child.parent_id=parent.member_id

 select
child.name as child_name,child.age as child_age,
parent.name as parent_name,parent.age as parent_age
from family as child
left join family as parent on child.parent_id=parent.member_id 