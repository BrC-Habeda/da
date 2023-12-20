import subprocess
import os
import psycopg2
from psycopg2 import sql
import time

# Primary database connection parameters
primary_params = {
    "host": "localhost",
    "port": 5432,  # Change this to your primary database port
    "user": "postgres",
    "password": "postgres",
    "database": "testdb",
}

# Replica database connection parameters
replica_params = {
    "host": "localhost",
    "port": 5433,  # Change this to your replica database port
    "user": "postgres",
    "password": "postgres",
    "database": "repdb",
}


def install_pglogical():
    try:
        # Install pglogical extension using subprocess
        subprocess.run(["pg_ctl", "stop", "-D", os.environ.get("PGDATA")])
        subprocess.run(["pg_logical", "install"])
        subprocess.run(["pg_ctl", "start", "-D", os.environ.get("PGDATA")])

    except subprocess.CalledProcessError as e:
        print(f"Error installing pglogical: {e}")


def create_replication_slot(conn):
    with conn.cursor() as cursor:
        cursor.execute(
            "SELECT pg_create_logical_replication_slot('your_slot_name', 'pgoutput');"
        )


def create_subscription(conn):
    with conn.cursor() as cursor:
        cursor.execute(
            sql.SQL("CREATE SUBSCRIPTION {} CONNECTION '{}'").format(
                sql.Identifier("your_subscription_name"),
                sql.SQL("host={} port={} dbname={} user={} password={}").format(
                    sql.Literal(replica_params["host"]),
                    sql.Literal(replica_params["port"]),
                    sql.Literal(replica_params["database"]),
                    sql.Literal(replica_params["user"]),
                    sql.Literal(replica_params["password"]),
                ),
            )
        )


def insert_data_from_script(conn, script_path):
    with conn.cursor() as cursor:
        with open(script_path, "r") as script_file:
            script_content = script_file.read()
            cursor.execute(script_content)


def query_replica(conn):
    with conn.cursor() as cursor:
        cursor.execute("SELECT * FROM course")
        rows = cursor.fetchall()
        print("Data in replica database:")
        for row in rows:
            print(row)


if __name__ == "__main__":
    try:
        # Install pglogical extension
        install_pglogical()

        # Connect to the primary and replica databases
        with psycopg2.connect(**primary_params) as primary_conn:
            with psycopg2.connect(**replica_params) as replica_conn:
                # Create replication slot on the primary database
                create_replication_slot(primary_conn)

                # Create subscription on the replica database
                create_subscription(replica_conn)

                # Insert data from SQL script into the primary database
                script_path = "../scripts/schema_test.sql"
                insert_data_from_script(primary_conn, script_path)

                # Introduce a delay to allow replication to catch up
                time.sleep(5)

                # Query the replica database
                query_replica(replica_conn)

                print("Replication test successful!")

    except Exception as e:
        print(f"Error: {e}")
