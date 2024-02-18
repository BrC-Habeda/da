-- 1661. Average Time of Process per machine

CREATE TABLE activity(
    machine_id int,
    process_id int,
    activity_type ENUM('start','stop'),
    timestamp float
);

INSERT INTO activity (machine_id,process_id,activity_type,timestamp)
VALUES
(0,0,'start',0.712),
(0,0,'end',1.520),
(0,1,'start',3.14),
(0,1,'end',4.120),
(1,0,'start',0.550),
(1,0,'end',1.550),
(1,1,'start',0.430),
(1,1,'end',1.420),
(2,0,'start',4.100),
(2,0,'end',4.512);

-- SQL Query

SELECT machine_id, ROUND(CAST(SUM(end_time - start_time) / COUNT(DISTINCT process_id) AS numeric), 3) AS processing_time
FROM(
    SELECT  machine_id,process_id,
            MAX(CASE WHEN activity_type = 'start' THEN timestamp END) AS start_time,
            MAX(CASE WHEN activity_type = 'end' THEN timestamp END) AS end_time
    FROM Activity
    GROUP BY machine_id, process_id  
) AS processed_activities
GROUP BY machine_id;

