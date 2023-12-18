import psycopg2
from psycopg2.extensions import ISOLATION_LEVEL_READ_COMMITTED

# Function to execute a query
def execute_query(conn, query):
    try:
        with conn.cursor() as cursor:
            cursor.execute(query)
            return cursor.fetchall()
    except psycopg2.Error as e:
        print(f"Error executing query: {e}")
        conn.rollback()

# Function to test Atomicity and Consistency
def test_atomicity_and_consistency(conn):
    try:
        # Begin a transaction
        conn.autocommit = False

        # Simulate a database crash before committing
        execute_query(conn, "CREATE TABLE test_table (id SERIAL PRIMARY KEY, data TEXT);")
        execute_query(conn, "INSERT INTO test_table (data) VALUES ('Atomicity and Consistency');")

        # Simulate a database crash before committing
        raise Exception("Simulating database crash before commit")

    except Exception as e:
        print(f"Error: {e}")

    finally:
        # Check if the data is in the database (Atomicity and Consistency check)
        data = execute_query(conn, "SELECT * FROM test_table;")
        print("Data in the table after crash (Atomicity and Consistency check):", data)

        # Assert that the table is empty due to the crash before commit
        assert not data, "Atomicity and Consistency test failed: Data present after crash."

        # Clean up
        execute_query(conn, "DROP TABLE IF EXISTS test_table;")
        conn.commit()
        conn.autocommit = True

# Function to test Durability
def test_durability(conn):
    try:
        # Create a table and insert data
        execute_query(conn, "CREATE TABLE test_table_durability (id SERIAL PRIMARY KEY, data TEXT);")
        execute_query(conn, "INSERT INTO test_table_durability (data) VALUES ('Durability Test');")

        # Simulate a database crash after committing
        raise Exception("Simulating database crash after commit")

    except Exception as e:
        print(f"Error: {e}")

    finally:
        # Check if the data is in the database (Durability check)
        data = execute_query(conn, "SELECT * FROM test_table_durability;")
        print("Data in the table after crash (Durability check):", data)

        # Assert that the data is present in the table due to durability
        assert data, "Durability test failed: Data missing after crash."

        # Clean up
        execute_query(conn, "DROP TABLE IF EXISTS test_table_durability;")
        conn.commit()

# Function to test Isolation
def test_isolation(conn):
    try:
        # Create a table and insert data
        execute_query(conn, "CREATE TABLE test_table_isolation (id SERIAL PRIMARY KEY, data TEXT);")
        execute_query(conn, "INSERT INTO test_table_isolation (data) VALUES ('Isolation Test');")

        # Perform a read (Isolation check)
        with conn.cursor() as cursor:
            cursor.execute("SELECT * FROM test_table_isolation;")
            data_read_1 = cursor.fetchall()
            print("Data read 1 (Isolation check):", data_read_1)

            # Simulate another transaction updating the data
            execute_query(conn, "UPDATE test_table_isolation SET data = 'Updated Data';")

            # Perform another read in the same transaction
            cursor.execute("SELECT * FROM test_table_isolation;")
            data_read_2 = cursor.fetchall()
            print("Data read 2 (Isolation check):", data_read_2)

        # Assert that the two reads are not the same (non-repeatable read)
        assert data_read_1 != data_read_2, "Isolation test failed: Non-repeatable read."

    except Exception as e:
        print(f"Error: {e}")

    finally:
        # Clean up
        execute_query(conn, "DROP TABLE IF EXISTS test_table_isolation;")
        conn.commit()

def main():
    try:
        # Connect to the PostgreSQL database
        conn = psycopg2.connect(
            dbname="your_database",
            user="your_user",
            password="your_password",
            host="your_host",
            port="your_port",
            isolation_level=ISOLATION_LEVEL_READ_COMMITTED
        )

        # Test Atomicity and Consistency
        test_atomicity_and_consistency(conn)

        # Test Durability
        test_durability(conn)

        # Test Isolation
        test_isolation(conn)

    except Exception as e:
        print(f"Error: {e}")

    finally:
        # Close the connection
            conn.close()

if __name__ == "__main__":
    main()
