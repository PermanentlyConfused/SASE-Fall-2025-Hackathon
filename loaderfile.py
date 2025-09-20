import psycopg2 as pg

try:
    conn = pg.connect(
        host = "",
        database = "",
        user = "",
        password =""
    )

except ps.Error as e:
    print(f"Error connecting to database: {e}")

