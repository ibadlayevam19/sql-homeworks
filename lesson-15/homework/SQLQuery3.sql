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
go


DECLARE @sql NVARCHAR(MAX);
DECLARE @json NVARCHAR(MAX);

-- Step 1: Build dynamic JSON properties selection
SET @sql = '
SELECT @jsonOutput = (
    SELECT STRING_AGG(
        ''{"property":"'' + col.column_name + ''","value":"'' + 
        ISNULL(CAST(c.'' + column_name + '' AS NVARCHAR(MAX)), ''NULL'') + ''"}'',
        '',''
    )
    FROM Contacts c
    CROSS APPLY (SELECT column_name FROM INFORMATION_SCHEMA.COLUMNS WHERE table_name = ''Contacts'' AND ordinal_position >= 3) col
);';

-- Step 2: Execute dynamic SQL
EXEC sp_executesql @sql, N'@jsonOutput NVARCHAR(MAX) OUTPUT', @json OUTPUT;

-- Step 3: Return JSON result
SELECT '[' + @json + ']' AS JSON_Result;
