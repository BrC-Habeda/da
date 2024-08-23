import os
from sqlalchemy import create_engine, text

def run_tests(sql_files):
    engine = create_engine("postgresql://postgres:postgres@localhost:5432/testdb")
    
    for sql_file in sql_files:
        try:
            # Read the SQL query from the file
            with open(sql_file, "r") as file:
                sql_query = file.read()

            # Connect to the database and execute the query
            with engine.connect() as conn:
                print(f"Executing query from {sql_file}:")
                print(sql_query)
                
                # Execute the query
                result = conn.execute(text(sql_query))

                # Fetch all rows from the query
                rows = result.fetchall()
                
                # Check if any rows were returned
                if not rows:
                    raise ValueError(f"No data returned for query in {sql_file}. Query: {sql_query}")

                # Perform assertions based on the file name or content
                if "1757" in sql_file:
                    expected_count = 2
                    assert len(rows) == expected_count, (
                        f"Test failed for {sql_file}: Expected {expected_count} but found {len(rows)}"
                    )

                if "584" in sql_file:
                    expected_count = 4
                    assert len(rows) == expected_count, (
                        f"Test failed for {sql_file}: Expected {expected_count} but found {len(rows)}"
                    )

                if "595" in sql_file:
                    expected_count = 2
                    assert len(rows) == expected_count, (
                        f"Test failed for {sql_file}: Expected {expected_count} but found {len(rows)}"
                    )

                if "1683" in sql_file:
                    expected_count = 1
                    assert len(rows) == expected_count, (
                        f"Test failed for {sql_file}: Expected {expected_count} but found {len(rows)}"
                    )

                if "1148" in sql_file:
                    expected_count = 2
                    assert len(rows) == expected_count, (
                        f"Test failed for {sql_file}: Expected {expected_count} but found {len(rows)}"
                    )

                if "1378" in sql_file:
                    expected_count = 5
                    assert len(rows) == expected_count, (
                        f"Test failed for {sql_file}: Expected {expected_count} but found {len(rows)}"
                    )

                if "1068" in sql_file:
                    expected_count = 3
                    assert len(rows) == expected_count, (
                        f"Test failed for {sql_file}: Expected {expected_count} but found {len(rows)}"
                    )

                if "1581" in sql_file:
                    expected_count = 3
                    assert len(rows) == expected_count, (
                        f"Test failed for {sql_file}: Expected {expected_count} but found {len(rows)}"
                    )

                if "197" in sql_file:
                    expected_count = 2
                    assert len(rows) == expected_count, (
                        f"Test failed for {sql_file}: Expected {expected_count} but found {len(rows)}"
                    )

                if "1661" in sql_file:
                    expected_count = 3
                    assert len(rows) == expected_count, (
                        f"Test failed for {sql_file}: Expected {expected_count} but found {len(rows)}"
                    )

                if "577" in sql_file:
                    expected_count = 3
                    assert len(rows) == expected_count, (
                        f"Test failed for {sql_file}: Expected {expected_count} but found {len(rows)}"
                    )

                if "1280" in sql_file:
                    expected_count = 12
                    assert len(rows) == expected_count, (
                        f"Test failed for {sql_file}: Expected {expected_count} but found {len(rows)}"
                    )

                if "570" in sql_file:
                    expected_count = 1
                    assert len(rows) == expected_count, (
                        f"Test failed for {sql_file}: Expected {expected_count} but found {len(rows)}"
                    )

                if "1934" in sql_file:
                    expected_count = 4
                    assert len(rows) == expected_count, (
                        f"Test failed for {sql_file}: Expected {expected_count} but found {len(rows)}"
                    )

                if "620" in sql_file:
                    expected_count = 2
                    assert len(rows) == expected_count, (
                        f"Test failed for {sql_file}: Expected {expected_count} but found {len(rows)}"
                    )

                if "1251" in sql_file:
                    expected_count = 2
                    assert len(rows) == expected_count, (
                        f"Test failed for {sql_file}: Expected {expected_count} but found {len(rows)}"
                    )

                if "1075" in sql_file:
                    expected_count = 2
                    assert len(rows) == expected_count, (
                        f"Test failed for {sql_file}: Expected {expected_count} but found {len(rows)}"
                    )

                if "1633" in sql_file:
                    expected_count = 5
                    assert len(rows) == expected_count, (
                        f"Test failed for {sql_file}: Expected {expected_count} but found {len(rows)}"
                    )

                if "1211" in sql_file:
                    expected_count = 2
                    assert len(rows) == expected_count, (
                        f"Test failed for {sql_file}: Expected {expected_count} but found {len(rows)}"
                    )

                if "1193" in sql_file:
                    expected_count = 3
                    assert len(rows) == expected_count, (
                        f"Test failed for {sql_file}: Expected {expected_count} but found {len(rows)}"
                    )

                # Immediate Food Delivery II
                if "1174" in sql_file:
                    row = result.fetchone()
                    if row is None:
                        raise ValueError(f"No data returned for query: {sql_query}")
                    value = row[0]
                    expected_value = 50.00
                    assert abs(value - expected_value) < 0.01, (
                        f"Test failed for {sql_file}: Expected {expected_value} but got {value}."
                    )

            print(f"Test passed for {sql_file}")

        except Exception as e:
            print(f"An error occurred while processing {sql_file}: {e}")

def test_queries():
    # Get the path to the leetcode folder
    leetcode_folder = os.path.join(os.path.dirname(__file__), "../leetcode")

    # Get all SQL files in the leetcode folder
    sql_files = [
        os.path.join(leetcode_folder, file)
        for file in os.listdir(leetcode_folder)
        if file.endswith(".sql")
    ]

    # Run tests on all SQL files
    run_tests(sql_files)

if __name__ == "__main__":
    test_queries()
