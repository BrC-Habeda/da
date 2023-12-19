import os
from sqlalchemy import create_engine, text, MetaData

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

        print("Query test passed successfully!")

    finally:
        # Close the database connection
        conn.close()

def test_schema():
    # Get the path to the SQL file in the root folder
    sql_file_path = os.path.join(os.path.dirname(__file__), '../scripts/schema_design.sql')

    # Read the SQL query from the file
    with open(sql_file_path, 'r') as sql_file:
        sql_query = sql_file.read()

    # Connect to the database and execute the SQL query
    engine = create_engine('postgresql://postgres:postgres@localhost:5432/testdb')
    conn = engine.connect()

    try:
        # Execute the SQL query to create the schema
        conn.execute(text(sql_query))

        # Fetch the actual schema from the database
        metadata = MetaData()
        metadata.reflect(bind=engine)

        # Specify the expected schema
        expected_schema = ['Student', 'Course', 'StudentCourses']  # Add your table names

        # Check if the actual schema matches the expected schema
        actual_schema = list(metadata.tables.keys())
        assert actual_schema == expected_schema, f"Expected schema {expected_schema}, but got {actual_schema}"

        print("Schema test passed successfully!")

    finally:
        # Close the database connection
        conn.close()

if __name__ == '__main__':
    test_query()
    test_schema()