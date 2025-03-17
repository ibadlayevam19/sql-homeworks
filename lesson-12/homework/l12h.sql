use homework12;
--task1

create table #FinalTb(
 DatabaseName varchar(50),
 SchemaName varchar(50),
 TableName varchar(50),
 ColumnName varchar(50),
 DataType varchar(50)
)

declare @alldb nvarchar(max);

declare @name varchar(max);
declare @i int=1;
declare @count int;
select @count=count(1) 
from sys.databases where name not in ('master', 'tempdb', 'model', 'msdb');
while @i<@count+1
begin
;with cte as(
select name, row_number() over(order by name) as rn
from sys.databases where name not in ('master', 'tempdb', 'model', 'msdb')
)
select @name=name from cte
where rn=@i
--updating dynamic sql for each database
set @alldb='
use ['+@name+'];
select 
	table_catalog as DatabaseName,
	table_schema as SchemaName,
	table_name as TableName,
	column_name as ColumnName,
	concat(data_type, ''(''+
		(case 
			when cast(character_maximum_length as varchar)=''-1''
			then ''max''
			else cast(character_maximum_length as varchar)
		end)
	+'')'') as DataType
from information_schema.columns;
'
--inserting to table
insert into #FinalTb
exec sp_executesql @alldb
--icrementing
set @i=@i+1
end;
select * from #FinalTb;
drop table #FinalTb;
go
--task2

alter procedure sp_func_proc @dbname varchar(max)=null
as
begin
	create table #finalview(
	  Name varchar(max),
	  Type varchar(50),
	  DatabaseName varchar(max),
	  SchemaName varchar(50),
	  Parameter varchar(50),
	  DataType varchar(50)
	);
	declare @sql nvarchar(max);
	declare @Databases table(
	ID int identity(1,1),
	Name varchar(max)
	);
	insert into @Databases(name)
	select name from sys.databases 
	where name not in('master','tempdb', 'model', 'msdb');
	declare @i int=1
	declare @count int;
	select @count=count(*) from @Databases;
		if @dbname is not null
		begin
			set @sql='
				use ['+@dbname+'];
				select 
				rt.routine_name as Name,
				rt.routine_type as Type,
				rt.routine_catalog as DatabaseName,
				rt.routine_schema as SchemaName,
				p.parameter_name as Parameter,
				concat(p.Data_Type, ''(''+
				(case
					when
						cast(p.character_maximum_length as varchar)=''-1''
						then ''max''
					else cast(p.character_maximum_length as varchar)
				end)
				+'')'') as DataType
				from information_schema.routines rt join information_schema.parameters p
				on rt.routine_name=p.specific_name';
			insert into #finalview
			exec sp_executesql @sql;
			select * from #finalview;
		end
		else
		begin
		    while @i<=@count
				begin
				select @dbname=name from @databases where id=@i;
				set @sql='
					use ['+@dbname+'];
					select 
					rt.routine_name as Name,
					rt.routine_type as Type,
					rt.routine_catalog as DatabaseName,
					rt.routine_schema as SchemaName,
					p.parameter_name as Parameter,
					concat(p.Data_Type, ''(''+
					(case
						when
							cast(p.character_maximum_length as varchar)=''-1''
							then ''max''
						else cast(p.character_maximum_length as varchar)
					end)
					+'')'') as DataType
					from information_schema.routines rt join information_schema.parameters p
					on rt.routine_name=p.specific_name';
				insert into #finalview
				exec sp_executesql @sql
			    set @i=@i+1
				end;
			select * from #finalview;
			
	    end;
		drop table #finalview;
end;
exec sp_func_proc;







