import os
from sqlalchemy import create_engine, text

def test_query():
    # Get the path to the SQL file in the root folder
    sql_file_path = os.path.join(os.path.dirname(__file__), '../scripts/schema_design.sql')

    # Read the SQL query from the file
    with open(sql_file_path, 'r') as sql_file:
        sql_query = sql_file.read()

    # Connect to the database and execute the SQL query
    engine = create_engine('postgresql://postgres:postgres@localhost:5432/testdb')
    conn = engine.connect()

    try:
        result = conn.execute(text(sql_query))
        # Fetch all rows from the result set
        rows = result.fetchall()

        # Check the actual result count against the expected count
        expected_count = 5
        assert len(rows) == expected_count, f"Expected {expected_count} rows, but got {len(rows)}"

        # You can add additional checks here if needed

        print("Test passed successfully!")

    finally:
        # Close the database connection
        conn.close()

if __name__ == '__main__':
    test_query()