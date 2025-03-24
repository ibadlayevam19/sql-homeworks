--task2
go
drop table if exists #view;
create table #view(
 num int identity(1,1),
 identifier_name nvarchar(max),
 identifier_value nvarchar(max),
 property nvarchar(max),
 value nvarchar(max)
)
declare @columns nvarchar(MAX);
declare @sql nvarchar(MAX);

select @columns = string_agg(quotename(column_name), ', ')
from information_schema.columns
where table_name = 'Contacts' AND ordinal_position >=3;


SET @sql = '
select identifier_name, identifier_value, columns AS property, entries AS value
from Contacts c
UNPIVOT (entries FOR columns IN (' + @columns + ')) anpvt;';

insert into #view(identifier_name, identifier_value, property, value)
EXEC sp_executesql @sql;
select * from #view;


declare @final nvarchar(max);
set @final='['+(
select string_agg(properties_json, ',') from(
select 
    identifier_name, 
    identifier_value,
    '{"'+identifier_name+'":"'+identifier_value+'","properties":[' + string_agg(
        '{"property":"' + property + '","value":"' + value + '"}', 
        ','
    ) + ']}' as properties_json
from #view
group by identifier_name, identifier_value) t1)+']';
select @final;
--[{"vid":"259429","properties":[{"property":"firstname","value":"Harper"},{"property":"lastname","value":"Wolfberg"},{"property":"website","value":"http://hubspot.com"},{"property":"company","value":"HubSpot"},{"property":"phone","value":"555-122-2323"},{"property":"address","value":"25 First Street"},{"property":"city","value":"Cambridge"},{"property":"state","value":"MA"},{"property":"zip","value":"02139"}]},{"vid":"321987","properties":[{"property":"firstname","value":"Robert"},{"property":"lastname","value":"Johnson"},{"property":"website","value":"http://robertj.com"},{"property":"company","value":"RJ Consulting"},{"property":"phone","value":"555-111-2222"},{"property":"address","value":"22 Lincoln Way"},{"property":"city","value":"Columbus"},{"property":"state","value":"OH"},{"property":"zip","value":"43215"}]},{"vid":"543210","properties":[{"property":"firstname","value":"Ava"},{"property":"lastname","value":"Smith"},{"property":"website","value":"http://example.com"},{"property":"company","value":"Example Corp"},{"property":"phone","value":"555-233-4545"},{"property":"address","value":"123 Maple Ave"},{"property":"city","value":"Springfield"},{"property":"state","value":"IL"},{"property":"zip","value":"62701"}]},{"vid":"654321","properties":[{"property":"firstname","value":"Michael"},{"property":"lastname","value":"Davis"},{"property":"website","value":"http://davistech.com"},{"property":"company","value":"Davis Technologies"},{"property":"phone","value":"555-444-5555"},{"property":"address","value":"99 Tech Park"},{"property":"city","value":"Seattle"},{"property":"state","value":"WA"},{"property":"zip","value":"98109"}]},{"vid":"987654","properties":[{"property":"firstname","value":"Jane"},{"property":"lastname","value":"Roe"},{"property":"website","value":"http://company.net"},{"property":"company","value":"Company LLC"},{"property":"phone","value":"555-678-1234"},{"property":"address","value":"789 Pine Rd"},{"property":"city","value":"New York"},{"property":"state","value":"NY"},{"property":"zip","value":"10001"}]},{"email":"alice.wonderland@fable.com","properties":[{"property":"firstname","value":"Alice"},{"property":"lastname","value":"Wonderland"},{"property":"website","value":"http://fable.com"},{"property":"company","value":"Fable Enterprises"},{"property":"phone","value":"555-987-6543"},{"property":"address","value":"102 Rabbit Hole"},{"property":"city","value":"Wonderland"},{"property":"state","value":"CA"},{"property":"zip","value":"90210"}]},{"email":"emily.brown@company.com","properties":[{"property":"firstname","value":"Emily"},{"property":"lastname","value":"Brown"},{"property":"website","value":"http://company.com"},{"property":"company","value":"Company Ltd"},{"property":"phone","value":"555-222-3333"},{"property":"address","value":"88 Blueberry Lane"},{"property":"city","value":"Austin"},{"property":"state","value":"TX"},{"property":"zip","value":"73301"}]},{"email":"john.doe@example.com","properties":[{"property":"firstname","value":"John"},{"property":"lastname","value":"Doe"},{"property":"website","value":"http://example.org"},{"property":"company","value":"Example Inc"},{"property":"phone","value":"555-345-6789"},{"property":"address","value":"456 Oak St"},{"property":"city","value":"Boston"},{"property":"state","value":"MA"},{"property":"zip","value":"02110"}]},{"email":"oliver.queen@starcity.com","properties":[{"property":"firstname","value":"Oliver"},{"property":"lastname","value":"Queen"},{"property":"website","value":"http://starcity.com"},{"property":"company","value":"Star City Industries"},{"property":"phone","value":"555-777-8888"},{"property":"address","value":"567 Arrow St"},{"property":"city","value":"Star City"},{"property":"state","value":"CA"},{"property":"zip","value":"94016"}]},{"email":"testingapis@hubspot.com","properties":[{"property":"firstname","value":"Codey"},{"property":"lastname","value":"Huang"},{"property":"website","value":"http://hubspot.com"},{"property":"company","value":"HubSpot"},{"property":"phone","value":"555-122-2323"},{"property":"address","value":"25 First Street"},{"property":"city","value":"Cambridge"},{"property":"state","value":"MA"},{"property":"zip","value":"02139"}]}]
