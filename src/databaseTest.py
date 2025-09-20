import psycopg2

conn = psycopg2.connect(
    dbname="home_db",
    user="postgres",
    password="Mlpnkobji123",
    host="localhost",
    port="5432"
)

try:
    cur = conn.cursor()
    cur.execute("INSERT INTO users (name, age, email) VALUES (%s, %s, %s)",
                ("Bob", 28, "HELPME"))
    conn.commit()
except Exception as e:
    print("Error:", e)
    conn.rollback()
finally:
    cur.close()
    conn.close()