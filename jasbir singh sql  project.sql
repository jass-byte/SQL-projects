create database project;
use project ;
#-------------------creating emmployees table--------------------------
create table employees 
( employee_id int primary key,
   emp_name  varchar (50),
   emp_city varchar(50),
   emp_joining date);
#--------------------creating salary table-----------------------------   
   create table salary 
   ( sal_id int primary key,
	 salary int,
     sal_increment float);
     
#--------------------creating departments table------------------------

create table departments ( dept_id int primary key,
						   dept_name varchar (50)
		                                         );
#--------------------employee_tenure_----------------------------------

create table emp_tenure (employee_id int,
    foreign key (employee_id) references employees (employee_id),
     sal_id int ,
     foreign key (sal_id) references salary (sal_id),
     dept_id int,
     foreign key (dept_id) references departments(dept_id),
     tenure int);
     
   alter table employees 
   add column gender varchar(30);
#--------------------inserting values----------------------------------

 insert into employees values (1, "Ruble", "Deharadun", "2003-01-14", "f"),
   (2, "Sanam", "Delhi", "2012-01-13", "m"),
   (3, "Harman", "chandigarh", "2014-03-24", "f"),
   (4, "Navkaran","Hisar","2021-01-12", "m"),
    (5, "Simran", "Ludhiana", "2015-07-19", "f"),
    (6, "Arjun", "Mumbai", "2018-02-11", "m"),
    (7, "Kavya", "Pune", "2019-05-22", "f"),
    (8, "Aman", "Jaipur", "2020-11-10", "m"),
    (9, "Mehak", "Amritsar", "2013-08-15", "f"),
    (10, "Rohan", "Bangalore", "2016-04-28", "m"),
    (11, "Tanya", "Noida", "2022-09-01", "f"),
    (12, "Yuvraj", "Kolkata", "2010-06-30", "m"),
    (13, "Priya", "Nagpur", "2017-03-18", "f"),
    (14, "Karan", "Lucknow", "2011-12-12", "m"),
    (15, "Neha", "Gurgaon", "2023-01-05", "f"),
    (16, "Ishaan", "Bhopal", "2014-10-09", "m"),
    (17, "Pooja", "Patna", "2012-02-17", "f"),
    (18, "Ritik", "Agra", "2009-09-21", "m");
                        
   insert into salary values ( 101, 200000, 0.1),
    (102,60000, 0.1),
    (103, 75000, 0.08),
    (104, 85000, 0.09),
    (105, 95000, 0.1),
    (106, 50000, 0.07),
    (107, 67000, 0.08),
    (108, 72000, 0.1),
    (109, 58000, 0.06),
    (110, 99000, 0.11),
    (111, 61000, 0.09),
    (112, 79000, 0.1),
    (113, 87000, 0.1),
    (114, 93000, 0.12),
    (115, 55000, 0.07),
    (116, 62000, 0.0),
    (117, 76500, 0.09),
    (118, 84500, 0.1);

    insert into departments values (201,'HR'),
    (202,"IT"),
    (203, 'Finance'),
    (204, 'Marketing'),
    (205, 'Operations'),
    (206, 'Sales'),
    (207, 'Legal'),
    (208, 'Customer Service'),
    (209, 'Research & Development'),
    (210, 'Procurement'),
    (211, 'Public Relations'),
    (212, 'Engineering'),
    (213, 'Training'),
    (214, 'Administration'),
    (215, 'Product Management'),
    (216, 'Security'),
    (217, 'Data Analytics'),
    (218, 'Quality Assurance');
 alter table emp_tenure
 drop constraint emp_tenure_ibfk_3;
 drop table departments;
 
 alter table emp_tenure
 add column departmenrt varchar(50);
 
 alter table emp_tenure
 drop column dept_id;
 
 insert into emp_tenure select e.employee_id, 100 + e.employee_id as sal_id, 
 timestampdiff(year,e.emp_joining, curdate()) as tenure,
 case when e.employee_id between 1 and 3  then "hr"
       when e.employee_id between 4 and 6  then "it"
       when e.employee_id between 7 and 9 then "logistics"
       when e.employee_id between 10 and 12 then "data analysis"
       when e.employee_id between 13 and 15 then "security"
       else "cleaning"
       end as department
       from employees as e
       where (100+ e.employee_id) in (select sal_id from salary);
       
       alter table emp_tenure
       rename column departmenrt to department
       ;
       set sql_safe_updates=0;
       select * from employees;
       select * from salary;
       select * from emp_tenure;
       update salary
       set salary=150000 where sal_id = 106;
#------------------------------------------------Exploratory data analysis-----------------------------------------------------------------------

# total employees 
select count(*) as totalemp from employees;
#-------by city ;
select emp_city,count(*) as toatlemps from employees
group by emp_city;
#ans: total=18
# ----by gender 
#ans: 9each
select gender, count(*)as total from employees
group by gender;

#------department with highest and lowest sal----------

select e.department, max(s.salary)as highest_salary from emp_tenure as e
join salary as s on s.sal_id=e.sal_id
group by e.department
order by highest_salary asc;
#ans: hr
select e.department, min(s.salary) as minimum_salary from emp_tenure as e
join salary as s on s.sal_id=e.sal_id
group by e.department
order by minimum_salary asc;
#ans: Housing
#---------departmen with max and min num of employees-------

select e.department, count(employee_id) as count_of_emp from emp_tenure as e
group by e.department
order by count_of_emp asc;
# ans: hr has the min. staff whereas it holds the max staff;

#----------each deparmtents highest paying employee-----------
select e1.emp_name as emp_name, ep1.department as depts, s1.salary as salary from employees as e1
join emp_tenure as ep1 on ep1.employee_id=e1.employee_id
join salary as s1 on s1.sal_id= ep1.sal_id
 where (ep1.department, s1.salary) in (select ep.department, max(s.salary) from emp_tenure as ep
join salary as s on s.sal_id=ep.sal_id
group by ep.department);

#ans-------------ruble from hr, Arjun form it, Rohan from Security, karan  from logistics, ririk from housing----------

#--city wise highest lowest salary-----------------
select e1.emp_name as emp, s1.salary as salary , e1.emp_city as city from employees as e1
join emp_tenure as ep1 on ep1.employee_id=e1.employee_id
join salary as s1 on s1.sal_id=ep1.sal_id
where (e1.emp_city, s1.salary) in
(select e.emp_city , max(salary) from employees as e
join emp_tenure as ep
on ep.employee_id =e.employee_id
join salary as s on s.sal_id=ep.sal_id
group by emp_city)
order by salary asc 
limit 5;

# ans: top 5 cities: Deharadun,Mumbai, banglore,Ludhiana, Lucknow.
#         5 lowest cities:  Gurgaon, Amritsar, Delhi ,Noida, Bhopal.

#-------------top 3 oldest employees-----------------------------------
select e.emp_name name, ep.department department, max(timestampdiff(year, e.emp_joining, curdate())) tenure from employees as e
join emp_tenure AS ep on ep.employee_id=e.employee_id
group by e.emp_name, department
order by tenure desc 
limit 5;
#Ans------------Ruble, ritik,Yuvraj-----------------------------------

#---------------departemnt with largest tenure employees--------------
select ep.department, round(avg(timestampdiff(year,e.emp_joining,curdate()))) avg_tenure
from employees as e
join emp_tenure  ep on ep.employee_id=e.employee_id
group by ep.department
order by avg_tenure desc 
limit 5;
#ANS: hr,  logistics, housing,it, security.

#--------------TOP 5 CITY WITH LARGEST TENURE_-----------------------------
select e.emp_city as cities, round(avg(timestampdiff(year,e.emp_joining, curdate()))) as avg_tenure
from employees as e
join emp_tenure as ep on ep.employee_id= e.employee_id
group by e.emp_city
order by avg_tenure desc
limit 5;
# ans: dehradun, agra, kolaktta,  delhi ,patna.

#-------------------------DEPARTMENT WITH LESS STABILITY-------------------------
select department, round(avg(tenure)) as avg_tenure_of_employees  from emp_tenure
group by department
order by avg_tenure_of_employees asc;
#ans: people from it and security are more on move while changing the company hr hr is htemost stable department.

#-------------------------gender wise stability----------------------------------
select e.gender as gender, round(avg(ep.tenure),2)as avg_tenure from emp_tenure as ep
join employees AS e on ep.employee_id=e.employee_id
group by gender;
#ANS: both gender have a very minute difference in stability though male has a slight more lengthy tenure than females.