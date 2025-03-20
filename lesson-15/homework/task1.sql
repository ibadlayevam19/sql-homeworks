use homework15;

--task1

drop table if exists Contacts;
create table Contacts
(
	identifier_name nvarchar(50),
	identifier_value nvarchar(255),
	firstname nvarchar(255),
	lastname nvarchar(255),
	website nvarchar(255),
	company nvarchar(255),
	phone nvarchar(255),
	address nvarchar(255),
	city nvarchar(255),
	state nvarchar(255),
	zip nvarchar(255),
);
insert into Contacts
values
    ('vid', '259429', 'Harper', 'Wolfberg', 'http://hubspot.com', 'HubSpot', '555-122-2323', '25 First Street', 'Cambridge', 'MA', '02139'),
	('email', 'testingapis@hubspot.com', 'Codey', 'Huang', 'http://hubspot.com', 'HubSpot', '555-122-2323', '25 First Street', 'Cambridge', 'MA', '02139'),
    ('email', 'john.doe@example.com', 'John', 'Doe', 'http://example.org', 'Example Inc', '555-345-6789', '456 Oak St', 'Boston', 'MA', '02110'),
    ('email', 'alice.wonderland@fable.com', 'Alice', 'Wonderland', 'http://fable.com', 'Fable Enterprises', '555-987-6543', '102 Rabbit Hole', 'Wonderland', 'CA', '90210'),
	('vid', '543210', 'Ava', 'Smith', 'http://example.com', 'Example Corp', '555-233-4545', '123 Maple Ave', 'Springfield', 'IL', '62701'),
    ('vid', '987654', 'Jane', 'Roe', 'http://company.net', 'Company LLC', '555-678-1234', '789 Pine Rd', 'New York', 'NY', '10001'),
    ('email', 'emily.brown@company.com', 'Emily', 'Brown', 'http://company.com', 'Company Ltd', '555-222-3333', '88 Blueberry Lane', 'Austin', 'TX', '73301'),
    ('vid', '321987', 'Robert', 'Johnson', 'http://robertj.com', 'RJ Consulting', '555-111-2222', '22 Lincoln Way', 'Columbus', 'OH', '43215'),
    ('vid', '654321', 'Michael', 'Davis', 'http://davistech.com', 'Davis Technologies', '555-444-5555', '99 Tech Park', 'Seattle', 'WA', '98109'),
    ('email', 'oliver.queen@starcity.com', 'Oliver', 'Queen', 'http://starcity.com', 'Star City Industries', '555-777-8888', '567 Arrow St', 'Star City', 'CA', '94016');
select * from Contacts;
declare @json varchar(max);
set @json='['
declare @i int=1;
declare @j int=3;
declare @countofcol int=(select max(ordinal_position) from information_schema.columns where table_name='Contacts')
declare @key nvarchar(max);
declare @value nvarchar(max);
declare @columnname nvarchar(max);
declare @sql nvarchar(max);
declare @result nvarchar(max);
while @i<=10
begin
	select @key=identifier_name, @value=identifier_value from (select row_number() over(order by identifier_name) as n, * from Contacts)tb1 where n=@i;
	set @json=@json+'{"'+@key+'":"'+@value+'", "properties":[';
		while @j<=@countofcol
		begin
		    set @columnname=(select column_name from information_schema.columns where table_name='Contacts' and ordinal_position=@j);
			set @sql='select @outValue = CAST(['+@columnname+'] AS NVARCHAR(MAX)) from (select row_number() over(order by identifier_name) as n, * from Contacts)tb1 where n='+cast(@i as nvarchar(max));
			EXEC sp_executesql @sql, N'@outValue NVARCHAR(MAX) OUTPUT', @result OUTPUT;
			set @json=@json+'{"property":'+'"'+@columnname+'", "value":" '+
			ISNULL(@result, 'NULL')+'"},';
			set @j=@j+1;
		end
		set @json=(select left(@json, len(@json)-1)+']},' where right(@json, 1)=',')
    set @j=3;
	set @i=@i+1;
end
select left(@json, len(@json)-1)+']' 
where right(@json, 1)=',';

/*declare @demo nvarchar(max);
set @demo=(
select left('lemon,bus, apple,', len('lemon,bus, apple,')-1)
where right('lemon,bus, apple,', 1)=',');
set @demo=@demo+(select column_name from information_schema.columns where table_name='Contacts' and ordinal_position=1);
select @demo;
select *
from information_schema.columns
where table_name='Contacts';
select (select column_name from information_schema.columns where table_name='Contacts' and ordinal_position=1) from Contacts
[{"email":"testingapis@hubspot.com", "properties":[{"property":"firstname", "value":" firstname"},{"property":"lastname", "value":" lastname"},{"property":"website", "value":" website"},{"property":"company", "value":" company"},{"property":"phone", "value":" phone"},{"property":"address", "value":" address"},{"property":"city", "value":" city"},{"property":"state", "value":" state"},{"property":"zip", "value":" zip"}]},{"email":"john.doe@example.com", "properties":[{"property":"firstname", "value":" firstname"},{"property":"lastname", "value":" lastname"},{"property":"website", "value":" website"},{"property":"company", "value":" company"},{"property":"phone", "value":" phone"},{"property":"address", "value":" address"},{"property":"city", "value":" city"},{"property":"state", "value":" state"},{"property":"zip", "value":" zip"}]},{"email":"alice.wonderland@fable.com", "properties":[{"property":"firstname", "value":" firstname"},{"property":"lastname", "value":" lastname"},{"property":"website", "value":" website"},{"property":"company", "value":" company"},{"property":"phone", "value":" phone"},{"property":"address", "value":" address"},{"property":"city", "value":" city"},{"property":"state", "value":" state"},{"property":"zip", "value":" zip"}]},{"email":"emily.brown@company.com", "properties":[{"property":"firstname", "value":" firstname"},{"property":"lastname", "value":" lastname"},{"property":"website", "value":" website"},{"property":"company", "value":" company"},{"property":"phone", "value":" phone"},{"property":"address", "value":" address"},{"property":"city", "value":" city"},{"property":"state", "value":" state"},{"property":"zip", "value":" zip"}]},{"email":"oliver.queen@starcity.com", "properties":[{"property":"firstname", "value":" firstname"},{"property":"lastname", "value":" lastname"},{"property":"website", "value":" website"},{"property":"company", "value":" company"},{"property":"phone", "value":" phone"},{"property":"address", "value":" address"},{"property":"city", "value":" city"},{"property":"state", "value":" state"},{"property":"zip", "value":" zip"}]},{"vid":"259429", "properties":[{"property":"firstname", "value":" firstname"},{"property":"lastname", "value":" lastname"},{"property":"website", "value":" website"},{"property":"company", "value":" company"},{"property":"phone", "value":" phone"},{"property":"address", "value":" address"},{"property":"city", "value":" city"},{"property":"state", "value":" state"},{"property":"zip", "value":" zip"}]},{"vid":"321987", "properties":[{"property":"firstname", "value":" firstname"},{"property":"lastname", "value":" lastname"},{"property":"website", "value":" website"},{"property":"company", "value":" company"},{"property":"phone", "value":" phone"},{"property":"address", "value":" address"},{"property":"city", "value":" city"},{"property":"state", "value":" state"},{"property":"zip", "value":" zip"}]},{"vid":"654321", "properties":[{"property":"firstname", "value":" firstname"},{"property":"lastname", "value":" lastname"},{"property":"website", "value":" website"},{"property":"company", "value":" company"},{"property":"phone", "value":" phone"},{"property":"address", "value":" address"},{"property":"city", "value":" city"},{"property":"state", "value":" state"},{"property":"zip", "value":" zip"}]},{"vid":"543210", "properties":[{"property":"firstname", "value":" firstname"},{"property":"lastname", "value":" lastname"},{"property":"website", "value":" website"},{"property":"company", "value":" company"},{"property":"phone", "value":" phone"},{"property":"address", "value":" address"},{"property":"city", "value":" city"},{"property":"state", "value":" state"},{"property":"zip", "value":" zip"}]},{"vid":"987654", "properties":[{"property":"firstname", "value":" firstname"},{"property":"lastname", "value":" lastname"},{"property":"website", "value":" website"},{"property":"company", "value":" company"},{"property":"phone", "value":" phone"},{"property":"address", "value":" address"},{"property":"city", "value":" city"},{"property":"state", "value":" state"},{"property":"zip", "value":" zip"}]}]
[{"email":"testingapis@hubspot.com", "properties":[{"property":"firstname", "value":" Codey"},{"property":"lastname", "value":" Huang"},{"property":"website", "value":" http://hubspot.com"},{"property":"company", "value":" HubSpot"},{"property":"phone", "value":" 555-122-2323"},{"property":"address", "value":" 25 First Street"},{"property":"city", "value":" Cambridge"},{"property":"state", "value":" MA"},{"property":"zip", "value":" 02139"}]},{"email":"john.doe@example.com", "properties":[{"property":"firstname", "value":" John"},{"property":"lastname", "value":" Doe"},{"property":"website", "value":" http://example.org"},{"property":"company", "value":" Example Inc"},{"property":"phone", "value":" 555-345-6789"},{"property":"address", "value":" 456 Oak St"},{"property":"city", "value":" Boston"},{"property":"state", "value":" MA"},{"property":"zip", "value":" 02110"}]},{"email":"alice.wonderland@fable.com", "properties":[{"property":"firstname", "value":" Alice"},{"property":"lastname", "value":" Wonderland"},{"property":"website", "value":" http://fable.com"},{"property":"company", "value":" Fable Enterprises"},{"property":"phone", "value":" 555-987-6543"},{"property":"address", "value":" 102 Rabbit Hole"},{"property":"city", "value":" Wonderland"},{"property":"state", "value":" CA"},{"property":"zip", "value":" 90210"}]},{"email":"emily.brown@company.com", "properties":[{"property":"firstname", "value":" Emily"},{"property":"lastname", "value":" Brown"},{"property":"website", "value":" http://company.com"},{"property":"company", "value":" Company Ltd"},{"property":"phone", "value":" 555-222-3333"},{"property":"address", "value":" 88 Blueberry Lane"},{"property":"city", "value":" Austin"},{"property":"state", "value":" TX"},{"property":"zip", "value":" 73301"}]},{"email":"oliver.queen@starcity.com", "properties":[{"property":"firstname", "value":" Oliver"},{"property":"lastname", "value":" Queen"},{"property":"website", "value":" http://starcity.com"},{"property":"company", "value":" Star City Industries"},{"property":"phone", "value":" 555-777-8888"},{"property":"address", "value":" 567 Arrow St"},{"property":"city", "value":" Star City"},{"property":"state", "value":" CA"},{"property":"zip", "value":" 94016"}]},{"vid":"259429", "properties":[{"property":"firstname", "value":" Harper"},{"property":"lastname", "value":" Wolfberg"},{"property":"website", "value":" http://hubspot.com"},{"property":"company", "value":" HubSpot"},{"property":"phone", "value":" 555-122-2323"},{"property":"address", "value":" 25 First Street"},{"property":"city", "value":" Cambridge"},{"property":"state", "value":" MA"},{"property":"zip", "value":" 02139"}]},{"vid":"321987", "properties":[{"property":"firstname", "value":" Robert"},{"property":"lastname", "value":" Johnson"},{"property":"website", "value":" http://robertj.com"},{"property":"company", "value":" RJ Consulting"},{"property":"phone", "value":" 555-111-2222"},{"property":"address", "value":" 22 Lincoln Way"},{"property":"city", "value":" Columbus"},{"property":"state", "value":" OH"},{"property":"zip", "value":" 43215"}]},{"vid":"654321", "properties":[{"property":"firstname", "value":" Michael"},{"property":"lastname", "value":" Davis"},{"property":"website", "value":" http://davistech.com"},{"property":"company", "value":" Davis Technologies"},{"property":"phone", "value":" 555-444-5555"},{"property":"address", "value":" 99 Tech Park"},{"property":"city", "value":" Seattle"},{"property":"state", "value":" WA"},{"property":"zip", "value":" 98109"}]},{"vid":"543210", "properties":[{"property":"firstname", "value":" Ava"},{"property":"lastname", "value":" Smith"},{"property":"website", "value":" http://example.com"},{"property":"company", "value":" Example Corp"},{"property":"phone", "value":" 555-233-4545"},{"property":"address", "value":" 123 Maple Ave"},{"property":"city", "value":" Springfield"},{"property":"state", "value":" IL"},{"property":"zip", "value":" 62701"}]},{"vid":"987654", "properties":[{"property":"firstname", "value":" Jane"},{"property":"lastname", "value":" Roe"},{"property":"website", "value":" http://company.net"},{"property":"company", "value":" Company LLC"},{"property":"phone", "value":" 555-678-1234"},{"property":"address", "value":" 789 Pine Rd"},{"property":"city", "value":" New York"},{"property":"state", "value":" NY"},{"property":"zip", "value":" 10001"}]}]
*/
go

