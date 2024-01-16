import os
from sqlalchemy import create_engine, text

def test_query():
    # Get the path to the SQL file
    sql_file_path = os.path.join(os.path.dirname(__file__),'../leetcode/1757.sql')
    
    # Read the sql query from the file
    with open(sql_file_path, 'r') as sql_file:
        sql_query = sql_file.read()
        
    # Connect to the database and execute the query
    engine = create_engine('postgresql://postgres:postgres@localhost:5432/testdb')
    conn = engine.connect()
    
        # Run the tests for the query
    try:
        result = conn.execute(text(sql_query))
        
        # Fetch all rows from the query
        rows = result.fetchall()
        
        expected_count = 2
        assert len(rows) == expected_count, f"Expected {expected_count} but found {len(rows)}"
        
        print("Test passed!")
    
    finally:
        conn.close()
        

if __name__ == '__main__':
    test_query()
