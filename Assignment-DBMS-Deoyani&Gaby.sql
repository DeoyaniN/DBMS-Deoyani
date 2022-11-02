/*1) create a table named EMPLOYEES (empno,name,job,hiredate,salary,commission,deptno)
   with empno as pk and deptno as fk 
   create table named DEPARTMENTS (deptno,name,location) with deptno as pk [2 marks]*/
   
   
create table DEPARTMENTS (
deptno number primary key,
name varchar2(50),
location VARCHAR2(100)
);

create table employees 
(empno number ,
name varchar2(50),
job varchar2(50),
hiredate date,
salary number(6,2),
commission number(6,2),
deptno number,
constraint pk1 primary key  (empno),
foreign key  (deptno) references departments (deptno)
);


   
/*
2) Insert 6-7 records to the table [0 marks]*/
insert into  DEPARTMENTS (
deptno,
name,
location)
values (1,'Marketing','Pune');
insert into  DEPARTMENTS (
deptno,
name,
location)
values (2,'Sales','Nashik');
insert into  DEPARTMENTS (
deptno,
name,
location)
values (3,'Engineering','Delhi');
insert into  DEPARTMENTS (
deptno,
name,
location)
values (4,'Quality','Nagpur');
insert into  DEPARTMENTS (
deptno,
name,
location)
values (5,'IT','Bangalore');
insert into  DEPARTMENTS (
deptno,
name,
location)
values (6,'SupplyChain','Mumbai');
insert into  DEPARTMENTS (
deptno,
name,
location)
values (7,'NPD','Kolkata');

insert into employees 
(empno ,name ,job ,hiredate ,salary ,commission ,deptno)
values (1, 'Deoyani', 'Manager', to_date('2020-06-20','yyyy-mm-dd'), '5222.6', 500, 3);

insert into employees 
(empno ,name ,job ,hiredate ,salary ,commission ,deptno)
values (2, 'Gaby', 'Sr Manager', to_date('2022-06-20','yyyy-mm-dd'), '5222.6', 500, 2);

insert into employees 
(empno ,name ,job ,hiredate ,salary ,commission ,deptno)
values (3, 'Kirti', 'Manager', to_date('2018-06-20','yyyy-mm-dd'), '6222.6', 100, 4);

insert into employees 
(empno ,name ,job ,hiredate ,salary ,commission ,deptno)
values (4, 'Jyoti', 'Assistant Manager', to_date('2020-01-20','yyyy-mm-dd'), '5299.6', 800, 5);

insert into employees 
(empno ,name ,job ,hiredate ,salary ,commission ,deptno)
values (5, 'Deepak', 'Manager', to_date('2021-06-20','yyyy-mm-dd'), '5200.9', 450, 6);

insert into employees 
(empno ,name ,job ,hiredate ,salary ,commission ,deptno)
values (6, 'Gaurav', 'DM', to_date('2020-12-29','yyyy-mm-dd'), '4500.6', 850, 7);

insert into employees 
(empno ,name ,job ,hiredate ,salary ,commission ,deptno)
values (7, 'Shoaib', 'Assistant Manager', to_date('2017-05-20','yyyy-mm-dd'), '5222.6', 500, 1);

insert into employees 
(empno ,name ,job ,hiredate ,salary ,commission ,deptno)
values (8, 'Swati', 'Assistant Manager', to_date('2017-05-20','yyyy-mm-dd'), '5222.6', 500, 1);
/*
3) Fire following queries on the table [2 marks each]

a) provide the names of all employees which belong to a department name "Engineering"
   and whose salary is between 1000 and 10000*/

select name
from employees 
where deptno = (select deptno from departments where name ='Engineering')
and salary between 1000 and 10000;

/*
b) provide the count of no of employees in a given dept_no*/

select count(*) countEmp ,deptno
from employees e 
group by deptno ;

/*c) update the commission of all employees by 60 percent*/

update employees
set commission=commission*1.6;

/*d) delete the employees whose commission is less than 1000 */

delete 
from employees
where commission<1000;

/*Mongodb [10 Marks]
----------------
Load the following supplier.json in the schema and perform the following queries [2 marks each]

/* please use aggregate framework */

//a) provide the supplier names of all supplier that belong to Pune/mumbai/bangalore [case insensitive]

// Requires official MongoShell 3.6+
db.getCollection("supplier").aggregate(
    [
        {
            "$match" : {
                "address" : {
                    "$in" : [
                        /pune/i,
                        /mumbai/i,
                        /bangalore/i
                    ]
                }
            }
        }, 
        {
            "$project" : {
                "name" : "$Name",
                "_id" : NumberInt(0)
            }
        }
    ] 
);


/*b) provide the suppliers who belong to pune and ratings in greater than three*/

// Requires official MongoShell 3.6+
db.getCollection("supplier").aggregate(
    [
        {
            "$match" : {
                "address" : /pune/i,
                "rating" : {
                    "$gt" : NumberLong(3)
                }
            }
        }, 
        {
            "$project" : {
                "name" : "$Name"
            }
        }
    ]
);
/*c) provide the name of the suppliers who supply tea */


// Requires official MongoShell 3.6+
db.getCollection("supplier").aggregate(
    [
        {
            "$match" : {
                "items_supplied" : "tea"
            }
        }, 
        {
            "$project" : {
                "name" : "$Name"
            }
        }
    ]
);

/*d) delete all suppliers who belong to Pune [case insensitive]*/

db.supplier.deleteMany(
{
"address": /pune/i
}
);

/*e) update all supplier's contact to null value*/

db.supplier.updateMany({},{"$set": {"contact" : null}});

--Cassandra [Optional ]
----------------
/*Create a table lms_book_details_by_publication_category 
with (PUBLICATION,CATEGORY) as partition key and book_code as clustering key 
and other columns BOOK_TITLE,AUTHOR,PUBLISH_DATE,PRICE,RACK_NUM,DATE_ARRIVAL
BOOK_EDITIONS is a list of all possible book editions that book can have  [2 marks]*/

use dbda;
Create table dbda.lms_book_details_by_publication_category 
(PUBLICATION varchar,
CATEGORY varchar, 
book_code varchar,
BOOK_TITLE varchar,
AUTHOR varchar,
PUBLISH_DATE date,
PRICE float,
RACK_NUM int,
DATE_ARRIVAL date,
primary key ((PUBLICATION,CATEGORY), book_code));


/*Insert some random 6 records to the table
write following queries : */

/*a) add to the existing list book edition number = -9999*/

insert into dbda.lms_book_details_by_publication_category 
(PUBLICATION,CATEGORY,book_code,BOOK_TITLE,AUTHOR,PUBLISH_DATE,PRICE,RACK_NUM,DATE_ARRIVAL)
values('Chand','storybook','s-1','Panchatatva','Deoyani','2022-12-01',67.90,1,'2022-12-09');

insert into dbda.lms_book_details_by_publication_category 
(PUBLICATION,CATEGORY,book_code,BOOK_TITLE,AUTHOR,PUBLISH_DATE,PRICE,RACK_NUM,DATE_ARRIVAL)
values('Tata Mcgraw Hill','Python','s-2','How to code in python','Gaby','2020-12-01',100.90,2,'2021-12-09');

insert into dbda.lms_book_details_by_publication_category 
(PUBLICATION,CATEGORY,book_code,BOOK_TITLE,AUTHOR,PUBLISH_DATE,PRICE,RACK_NUM,DATE_ARRIVAL)
values('Sunny','Poembook','s-3','Zara','Achari','2021-12-01',40.90,3,'2022-12-09');

insert into dbda.lms_book_details_by_publication_category 
(PUBLICATION,CATEGORY,book_code,BOOK_TITLE,AUTHOR,PUBLISH_DATE,PRICE,RACK_NUM,DATE_ARRIVAL)
values('Tata Mcgraw Hill','Java','s-4','advance java','Kirti','2017-12-01',120.90,4,'2021-12-09');

insert into dbda.lms_book_details_by_publication_category 
(PUBLICATION,CATEGORY,book_code,BOOK_TITLE,AUTHOR,PUBLISH_DATE,PRICE,RACK_NUM,DATE_ARRIVAL)
values('Chand','storybook','s-5','Panch','Jyoti','2022-12-01',67.90,5,'2022-12-09');

insert into dbda.lms_book_details_by_publication_category 
(PUBLICATION,CATEGORY,book_code,BOOK_TITLE,AUTHOR,PUBLISH_DATE,PRICE,RACK_NUM,DATE_ARRIVAL)
values('Tata Mcgraw Hill','Java','s-6','Core Java','Gaurav','2022-12-01',150.90,6,'2022-12-09');

/*a) add to the existing list book edition number = -9999
	where publication is 'Tata Mcgraw Hill' and category is 'Java' 
	for a particular book_code of your choice*/

ALTER table dbda.lms_book_details_by_publication_category 
add ( editionnumbers list<int>);


update dbda.lms_book_details_by_publication_category 
set editionnumbers=[-9999]
WHERE publication ='Tata Mcgraw Hill' and category ='Java' AND book_code ='s-4';

update dbda.lms_book_details_by_publication_category 
set editionnumbers=[-9999, 1, 565]
WHERE publication ='Tata Mcgraw Hill' and category ='Java' AND book_code ='s-4';


/*b) select all books where publication is 'Tata Mcgraw Hill' and category is 'Java' */

SELECT *
from dbda.lms_book_details_by_publication_category 
WHERE publication ='Tata Mcgraw Hill' and category ='Java';


/*c) Add a new column to the table named "my_comments"  of datatype text*/

ALTER table dbda.lms_book_details_by_publication_category 
add ( my_comments text);

/*d) Update BOOK_TITLE to "My_hardcoded_string"
	where publication is 'Tata Mcgraw Hill' and category is 'Java'
	for a particular book_code of your choice*/
	
	update dbda.lms_book_details_by_publication_category 
	set BOOK_TITLE = 'My_hardcoded_string'
	WHERE publication ='Tata Mcgraw Hill' and category ='Java'
	AND book_code ='s-4';