CREATE TABLE Queries (
    query_name VARCHAR,
    result VARCHAR,
    position INT,
    rating INT
);

INSERT INTO Queries (query_name, result, position, rating) VALUES
('null', 'Golden Retriever', 1, 5),
('null', 'German Shepherd', 2, 5),
('null', 'Mule', 200, 1),
('Cat', 'Shirazi', 5, 2),
('Cat', 'Siamese', 3, 3),
('Cat', 'Sphynx', 7, 4);

SELECT query_name,
    ROUND(AVG(CAST(rating AS DECIMAL) / position), 2) AS quality,
    ROUND((SUM(CASE WHEN rating < 3 THEN 1 ELSE 0 END) * 100.0) / COUNT(*), 2) AS poor_query_percentage
FROM Queries
WHERE query_name IS NOT NULL
GROUP BY query_name;