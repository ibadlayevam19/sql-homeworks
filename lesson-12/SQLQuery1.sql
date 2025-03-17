use class12;
--stored Procedure 
--create proc/procedure <name>
--as
--begin
	--<statement1>
	--<statement2>
	--<statement3>
--end;

--exec <name>
--execute <name>


--while <condition>
--begin
   --<statement>
--end

exec sp_who;

--Dynamic SQl
--declare @sql_cmd varchar (50) ='Select * from '
--set @sql_cmd=@sql_cmd+ 'emp'
--select @sql_cmd;
drop table if exists #t;
create table #t (id int);
insert into #t
values (1), (2), (3), (4), (5);
select top 3 * from #t;
alter proc sp_select_all @table_name varchar(255), @top_k int
as
begin
	declare @sql_cmd varchar(50)='select top number * from '
	set @sql_cmd=replace(@sql_cmd, 'number', @top_k)+@table_name;
	exec( @sql_cmd);
end;
exec sp_select_all '#t', 4; 

