-- 1683. Invalid Tweets
-- Write a solution to find the IDs of the invalid tweets
-- A tweet invalid if the number of characters used in the content of the tweet is > 15

-- CREATE THE TABLE 
CREATE TABLE tweets(
    tweet_id INT,
    content varchar
);

-- Insert the data in the table

INSERT INTO tweets(tweet_id,content)
VALUES
(1,'Vote for Biden'),
(2,'Let us make America great again!');

-- SQL Query

SELECT tweet_id
FROM tweets
WHERE CHAR_LENGTH(content) > 15;