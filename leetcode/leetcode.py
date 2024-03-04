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
            
            # Big Countries
            if "595" in sql_file:
                expected_count = 2
                assert len(rows) == expected_count, f"Test failed for {sql_file}: Expected {expected_count} but found {len(rows)}"
            
            # Invalid Tweets
            if "1683" in sql_file:
                expected_count = 1
                assert len(rows) == expected_count, f"Test failed for {sql_file}: Expected {expected_count} but fount {len(rows)}"
            
            # Article Views
            if "1148" in sql_file:
                expected_count = 2
                assert len(rows) == expected_count, f"Test failed for {sql_file}: Expected {expected_count} but found {len(rows)}"
            
            # Replace EmployeeID
            if "1378" in sql_file:
                expected_count = 5
                assert len(rows) == expected_count, f"Test failed for {sql_file}: Expected {expected_count} but found {len(rows)}"
            
            # Product Sales Analysis I
            if "1068" in sql_file:
                expected_count = 3
                assert len(rows) == expected_count, f"Test failed for {sql_file}: Expected {expected_count} but found {len(rows)}"
            
            # Customers who visited without making any transactions
            if "1581" in sql_file:
                expected_count = 3
                assert len(rows) == expected_count, f"Test failed for {sql_file}: Expected {expected_count} but found {len(rows)}"
            
            # Rising temperature
            if "197" in sql_file:
                expected_count = 2
                assert len(rows) == expected_count, f"Test failed for {sql_file}: Expected {expected_count} but found {len(rows)}"
            
            # Average time of process per machine
            if "1661" in sql_file:
                expected_count = 3
                assert len(rows) == expected_count, f"Test failed for {sql_file}: Expectation differences"
            
            # Employee Bonus
            if "577" in sql_file:
                expected_count = 3
                assert len(rows) == expected_count, f"Test failed for {sql_file}: Expectation differences"
                
            # Students and Examinations
            if "1280" in sql_file:
                expected_count = 12
                assert len(rows) == expected_count, f"Test failed for {sql_file}: Expectation differences"
            
            # Managers with direct reports
            if "570" in sql_file:
                expected_count = 1
                assert len(rows) == expected_count, f"Test failed for {sql_file}: Expectation differences"
            print(f"Test passed for {sql_file}")
            
            # Confirmation Rate
            if "1934" in sql_file:
                expected_count = 4
                assert len(rows) == expected_count, f"Test failed for {sql_file}: Expectation differences"
            
            # Not boring movies
            if "620" in sql_file:
                expected_count = 2
                assert len(rows) == expected_count, f"Test failed for {sql_file}: Expectation differences"
                
            # Average Selling Price
            if "1251" in sql_file:
                expected_count = 2
                assert len(rows) == expected_count, f"Test failed for {sql_file}: Expectation differences"
            
            # Cities with stopovers
            if "cities" in sql_file:
                expected_count = 2
                assert len(rows) == expected_count, f"Test failed for {sql_file}: Expectation differences"

            # Project Employees
            if "1075" in sql_file:
                expected_count = 2
                assert len(rows) == expected_count, f"Test failed for {sql_file}: Expectation differences"
            
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
