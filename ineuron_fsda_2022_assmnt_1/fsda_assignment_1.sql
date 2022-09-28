-- task.1&2 goal is to list the names(clients) who spoke for atleast 10 minutes on the phone.

create database fsda_testing
use fsda_testing

create table phones(
name varchar (90) not null unique,
phone_number int not null unique) 

create table calls(
id int not null,
caller int not null,
callee int not null,
duration int not null,
unique(id))

insert into phones values ('Jack' , 1234 ),('Leena' , 3333),('Mark',9999),('Anna',7582),('John',6356),
('Addison',4315),('Kate',8003),('Ginny',9831)

insert into calls values (25,1234,7582,8),(7,9999,7582,1),(18,9999,3333,4),(2,7582,3333,3),
(3,3333,1234,1),(21,3333,1234,1),(65,8003,9831,7),(100,9831,8003,3),(145,4315,8003,18)

select * from phones
select * from calls

alter table calls add constraint foreign key (caller) references phones(phone_number)

desc phones
desc calls

select name, sum(duration) from phones join calls on phones.phone_number = calls.caller group by name
select name, sum(duration) from phones join calls on phones.phone_number = calls.callee group by name

create table from_caller (Name1 varchar(200), Call_Duration int);
create table from_callee(Name2 varchar(200), Call_Duration int);

insert into from_caller  select name, sum(duration) from phones join calls on phones.phone_number = calls.caller group by name
insert into from_callee select name, sum(duration) from phones join calls on phones.phone_number = calls.callee group by name

select * from from_caller
select * from from_callee
select * from from_caller union select * from from_callee

select name from (select name1 as name , sum(call_duration) as call_time from (select * from from_caller union select * from from_callee) 
as result group by 
name having call_time >=10 order by name) as results 







-- 3. the goal is to obtain a single 3 single column 'BALANCE' for 3 different tables respectively. 
-- (a) 'BALANCE' = 2746 (b) 'BALANCE' = -617 (c) 'BALANCE' = 20940

create table transactions (
ammount int not null,
date date not null)

select * from transactions


insert into transactions values (1000, '2020-01-06'),(-10, '2020-01-14'),
(-75, '2020-01-20'),(-5, '2020-01-25'),(-4, '2020-01-29'),(2000, '2020-03-10'),(-75, '2020-03-12'),
(-20, '2020-03-15'),(40, '2020-03-15'),(-50, '2020-03-17'),(200, '2020-10-10'),(-200, '2020-10-10')



create table credit_card_fee(
ammount int not null,
date date not null)

insert into credit_card_fee values (-5, '2020-01-01')
insert into credit_card_fee values (-5, '2020-02-01'),(-5, '2020-04-01'),(-5, '2020-05-01'),(-5, '2020-06-01'),
(-5, '2020-07-01'),(-5, '2020-08-01'),(-5, '2020-09-01'),(-5, '2020-10-01'),(-5, '2020-11-01'),(-5, '2020-12-01')

select * from transactions
union
select * from credit_card_fee

create table transactions_1 (ammount int not null, date date)
insert into transactions_1 values (1, '2020-06-29'), (35, '2020-02-20'), (-50, '2020-02-03'), (-1, '2020-02-26'), (-200, '2020-08-01'),
(-44, '2020-02-07'),(-5, '2020-02-25'),(1, '2020-06-29'),(1, '2020-06-29'),(-100, '2020-12-29'),(-100, '2020-12-30'),(-100, '2020-12-31')

select sum(ammount) as balance from (select * from transactions_1
union all
select * from credit_card_fee) as final_result

select sum(ammount) from transactions_1
select sum(ammount) from credit_card_fee

create table tansactions_2 (ammount int not null, date date not null)
insert into tansactions_2 values (6000, '2020-04-03'),(5000, '2020-04-02'),(4000, '2020-04-01'),(3000, '2020-03-01'),
(2000, '2020-02-01'),(1000, '2020-01-01')

select * from tansactions_2

create table cr_card_fee_per_year (
ammount int not null,
date date not null)
insert into cr_card_fee_per_year values (-5, '2020-01-01'),(-5, '2020-02-01')
insert into cr_card_fee_per_year values (-5, '2020-03-01'),(-5, '2020-04-01'),(-5, '2020-05-01'),(-5, '2020-06-01'),
(-5, '2020-07-01'),(-5, '2020-08-01'),(-5, '2020-09-01'),(-5, '2020-10-01'),(-5, '2020-11-01'),(-5, '2020-12-01')

select sum(ammount) as balance from (select * from tansactions_2
union
select * from cr_card_fee_per_year) as final_result

