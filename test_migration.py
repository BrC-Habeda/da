import os
from sqlalchemy import create_engine, text

def test_migration():
    # Get the path to the SQL File in the root directory
    sql_insert_path = os.path.join(os.path.dirname(__file__), '../scripts/migration.sql')
    
    # Read the contents of the SQL file
    with open(sql_insert_path, 'r') as sql_file:
        sql_query = sql_file.read()
        
    # Connect to the database
    engine = create_engine('postgresql://postgres:postgres@localhost:5432/testdb')
    conn = engine.connect()
    
    try:
        insert = conn.execute(text(sql_query))
        # Fetch rows from the insert set
        rows = insert.fetchall()
        
        #Check the actual result v the expected result
        expected_count = 1
        assert len(rows) == expected_count, f"Expected {expected_count} rows, but got {len(rows)}"
        
        print("Test passed successfully")
    
    finally:
        #Close the database connection
        conn.close()
        
if __name__ == '__main__':
    test_migration()

