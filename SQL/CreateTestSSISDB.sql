use master
go
if db_id('TestSSIS') is null
begin
	create database TestSSIS;
end
go
alter database TestSSIS set recovery simple;
go
SELECT name, recovery_model_desc  
   FROM sys.databases  
      WHERE name = 'TestSSIS' ;
go
use TestSSIS;
go
drop table if exists Source;
drop table if exists Destination;
create table Source(s varchar(2048) not null);
create table Destination(s varchar(2048) not null);
with cte2 as (select * from (values(replicate('a', 2048)), (replicate('b', 2048))) as a(s)),  
cte4		as (select a.* from cte2		as a cross join cte2		),
cte16		as (select a.* from cte4		as a cross join cte4		),
cte256		as (select a.* from cte16		as a cross join cte16		),
cte65536	as (select a.* from cte256		as a cross join cte256		),
cte1048576	as (select a.* from cte65536	as a cross join cte16		),
cte16777216	as (select a.* from cte65536	as a cross join cte256	)
insert into Source(s) select s from cte16777216;
select count(*) from Source;
