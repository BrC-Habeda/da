import os
from sqlalchemy import create_engine, text

def run_tests(sql_files):
    for sql_file in sql_files:
        # Read the sql query from the file
        with open(sql_file, 'r') as file:
            sql_query = file.read()

        # Connect to the database and execute the query
        engine = create_engine('postgresql://postgres:postgres@localhost:5432/testdb')
        conn = engine.connect()

        # Run the tests for the query
        try:
            result = conn.execute(text(sql_query))

            # Fetch all rows from the query
            rows = result.fetchall()

            # Perform assertions based on the file name or content
            if "1757" in sql_file:
                expected_count = 2
                assert len(rows) == expected_count, f"Test failed for {sql_file}: Expected {expected_count} but found {len(rows)}"

            # Add more assertions for other files as needed
            if "584" in sql_file:
                expected_count = 4
                assert len(rows) == expected_count, f"Test failed for {sql_file}: Expected {expected_count} but found {len(rows)}"
                
            
            print(f"Test passed for {sql_file}")

        finally:
            conn.close()

def test_queries():
    # Get the path to the leetcode folder
    leetcode_folder = os.path.join(os.path.dirname(__file__), '../leetcode')

    # Get all SQL files in the leetcode folder
    sql_files = [os.path.join(leetcode_folder, file) for file in os.listdir(leetcode_folder) if file.endswith('.sql')]

    # Run tests on all SQL files
    run_tests(sql_files)

if __name__ == '__main__':
    test_queries()
