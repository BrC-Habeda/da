-- Create a sample sales table
CREATE TABLE sales (
  sale_date DATE,
  amount DECIMAL(10, 2)
);

-- Insert some sample data
INSERT INTO sales (sale_date, amount) VALUES
  ('2023-01-01', 100.50),
  ('2023-01-02', 150.75),
  ('2023-01-04', 200.00);