# Exploring FAQ in SQL interviews.

Let's say you have a table named sales with columns sale_date and amount, and you want to analyze the total sales for each date within a given range. If there are days with no sales, you still want to include those dates in the result.

```bash
-- Create a sample sales table
CREATE TABLE sales (
  sale_date DATE,
  amount DECIMAL(10, 2)
);
```

```bash
-- Insert some sample data
INSERT INTO sales (sale_date, amount) VALUES
  ('2023-01-01', 100.50),
  ('2023-01-02', 150.75),
  ('2023-01-04', 200.00);
```

```bash
-- Generate a series of dates for a specific range
WITH DateSeries AS (
  SELECT generate_series(
           (SELECT MIN(sale_date) FROM sales),
           (SELECT MAX(sale_date) FROM sales),
           interval '1 day'
         )::DATE AS sale_date
)
-- Combine with SQL statement to analyze data
SELECT
  ds.sale_date,
  COALESCE(SUM(s.amount), 0) AS total_sales
FROM
  DateSeries ds
LEFT JOIN
  sales s ON ds.sale_date = s.sale_date
GROUP BY
  ds.sale_date
ORDER BY
  ds.sale_date;
```
