import os
from sqlalchemy import create_engine, text

def test_query():
    # Get the path to the SQL file in the root folder
    sql_file_path = os.path.join(os.path.dirname(__file__), '../scripts/series_generate.sql')

    # Read the SQL query from the file
    with open(sql_file_path, 'r') as sql_file:
        sql_query = sql_file.read()

    # Connect to the database and execute the SQL query
    engine = create_engine('postgresql://postgres:postgres@localhost:5432/testdb')
    conn = engine.connect()

    try:
        result = conn.execute(text(sql_query))
        assert result.scalar() == 4  # Change this based on your expected result count
        print("Result:", result.fetchall())
    finally:
        conn.close()

if __name__ == '__main__':
    test_query()
