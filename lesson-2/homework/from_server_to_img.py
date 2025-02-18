import pyodbc #SQL server
con_str="DRIVER={SQL SERVER}; SERVER=DESKTOP-FT5TB39\SQLEXPRESS; DATABASE=homework2; Trusted_Connection=yes;"
con=pyodbc.connect(con_str)
cursor=con.cursor()

cursor.execute(
    """
    SELECT * FROM photos;
    """
)
row = cursor.fetchone()
id, name, photo=row
with open(f"{name}.png", 'wb') as f:
    f.write(photo)