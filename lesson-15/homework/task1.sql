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
DECLARE @json NVARCHAR(MAX);
SET @json = (
    SELECT 
        identifier_name AS [key], 
        identifier_value AS value,
        (
            SELECT 
                COLUMN_NAME AS property, 
                CAST(C.[identifier_value] AS NVARCHAR(MAX)) AS value
            FROM INFORMATION_SCHEMA.COLUMNS IC
            CROSS APPLY (SELECT TOP 1 * FROM Contacts T WHERE T.identifier_name = C.identifier_name) C
            WHERE IC.TABLE_NAME = 'Contacts' 
            AND IC.ORDINAL_POSITION >= 3
            FOR JSON PATH
        ) AS properties
    FROM Contacts C
    FOR JSON PATH, ROOT('Contacts')
);
SELECT @json;


go

declare @json nvarchar(max);

declare @properties nvarchar(max);
set @properties=
(select string_agg('{"property":"'+column_name+'","value":"', '},') from information_schema.columns 
where table_name='Contacts' and ordinal_position>=3);

set @json=
  (select STRING_AGG('{"' + identifier_name + '": "' + identifier_value + '", "properties":["property:"'+@properties+'"]}', ', ') from Contacts);
select @json;

select firstname from Contacts;
select * from Contacts where identifier_value='259429'
select '{"'+concat(identifier_name,'":"', identifier_value, '", "properties":[]}') from Contacts;
select column_name from information_schema.columns where table_name='Contacts' and ordinal_position>=3; 
select * from contacts;
declare @sql nvarchar(max)=
'select @outValue = CAST(['+column_name+'] AS NVARCHAR(MAX)) from Contacts where identifier_value=''259429''
cross apply (SELECT column_name FROM INFORMATION_SCHEMA.COLUMNS WHERE table_name = ''Contacts'' AND ordinal_position >= 3) col'
with cter as(
select 3 as n, (select column_name from information_schema.columns where table_name='Contacts' and ordinal_position=3) as column_name,
(select firstname from Contacts where identifier_value='259429') as value
union all
select n+1, (select column_name from information_schema.columns where table_name='Contacts' and ordinal_position=n+1),  from cter
)
;with cte as (
  select 1 as n, 
  (select string_agg('{"property":"'+column_name+'","value":', '},') from information_schema.columns where table_name='Contacts' and ordinal_position>=3) as property, 
  (select STRING_AGG('{"' + identifier_name + '": "' + identifier_value + '", "properties":'+@properties+'"]}', ', ')
    FROM Contacts c) as code
	union all
	select n+1,property, code from cte
	where n<10
)
select * from cte;
select column_name from information_schema.columns where table_name='Contacts' and ordinal_position>=3;

SET @json = '[' + @json + ']';  
SELECT @json;


go
declare @countofcol int=(select max(ordinal_position) from information_schema.columns where table_name='Contacts')
select column_name from information_schema.columns where table_name='Contacts' and ordinal_position>=3;
with cte as 
(

)


