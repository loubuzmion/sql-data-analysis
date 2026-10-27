SELECT * FROM games_description;

SELECT * FROM games_revenue;

SELECT * FROM games_reviews;

/*
Task 3. Data Analysis


Question 1. Total Revenue

Calculate total revenue for each game: Total Revenue = Number_of_Purchases * Unit_Price

What are the top 5 games by revenue?

Identify the top 3 genres by total revenue.

Which year generated most of the revenue in the company.
*/

SELECT 
		game_name,
		FORMAT(Number_of_Purchases * Unit_Price, 0) AS Total_Revenue
FROM 	
		games_description
LEFT JOIN 
		games_revenue ON games_description.game_id = games_revenue.game_id
ORDER BY 
		(Number_of_Purchases * Unit_Price) DESC;




-- What are the top 5 games by Revenue
SELECT 
		gd.game_name,
		FORMAT(Number_of_Purchases * Unit_Price, 0) AS Total_Revenue
FROM 
		games_description gd
LEFT JOIN 
		games_revenue ON gd.game_id = games_revenue.game_id
ORDER BY 
		Number_of_Purchases * Unit_Price DESC
LIMIT 5;




-- Identify the top 3 genres by Total Revenue
SELECT 
		genre,
		FORMAT(SUM(Number_of_Purchases * Unit_Price), 2) AS Total_Revenue
FROM 
		games_description
LEFT JOIN 
		games_revenue ON games_description.game_id = games_revenue.game_id
GROUP BY 
		genre
ORDER BY 
		SUM(Number_of_Purchases * Unit_Price) DESC
LIMIT 3;




-- Which year generated most of the revenue in the company
SELECT
		year_released,
        FORMAT(SUM(number_of_purchases * unit_price), 2) AS total_revenue,
        DENSE_RANK() OVER (ORDER BY SUM(number_of_purchases * unit_price) DESC) AS rank_year
FROM
		games_description
LEFT JOIN
		games_revenue ON games_description.game_id = games_revenue.game_id
GROUP BY
		year_released;




/*
Question 2. Review Percentage
Calculate the percentage of customers who left reviews out of the total purchase.
*/
SELECT 
		(SUM(number_of_reviews_from_purchased_people) / 
        SUM(Number_of_Purchases)) *100 AS percentage_of_cust_who_left_reviews
FROM 
		games_reviews
LEFT JOIN 
		games_revenue ON games_reviews.game_id = games_revenue.game_id;




/* 
Question 3. English Review Analysis
Determine the percentage of reviews written in English for each game
*/
SELECT
		gd.game_name,
        ROUND((gr.number_of_english_reviews * 100.0 /
        gr.number_of_reviews_from_purchased_people), 2) AS english_review_percentage
FROM games_reviews gr
JOIN games_description gd ON gr.game_id = gd.game_id
ORDER BY english_review_percentage DESC;
        
-- flaggin the bad rows
SELECT 
    game_id,
    number_of_english_reviews,
    number_of_reviews_from_purchased_people
FROM games_reviews
WHERE number_of_english_reviews > number_of_reviews_from_purchased_people;


/*
Some games have more English reviews than total reviews, 
resulting in percentages above 100%. This indicates inconsistencies in the dataset.
*/
SELECT
		gd.game_name,
        gd.game_id,
        LEAST(ROUND((gr.number_of_english_reviews * 100.0 /
        gr.number_of_reviews_from_purchased_people), 2), 100) AS english_review_percentage
FROM games_reviews gr
JOIN games_description gd ON gr.game_id = gd.game_id
ORDER BY english_review_percentage DESC;

-- Question 4.
-- ---------------------------------------------------------------------------------------------------------------------
/*
Task 3. Data Analysis
*/
-- Guide Sample
SELECT
		gd.game_name,
        number_of_purchases,
        hours_played
FROM 	games_description gd
JOIN
		games_revenue ON gd.game_id = games_revenue.game_id
JOIN
		games_reviews ON gd.game_id = games_reviews.game_id
ORDER BY
		number_of_purchases DESC;
        

-- Question 1. Total Revenue
-- Calculate total revenue for each game: Total Revenue = Number_of_Purchases * Unit_Price
SELECT
		gd.game_name,
		FORMAT(SUM(number_of_purchases * unit_price), 2) AS total_revenue
FROM	games_description gd
JOIN
		games_revenue ON gd.game_id = games_revenue.game_id
GROUP BY game_name;



-- What are the top 5 games by revenue?
SELECT
		gd.game_name,
		FORMAT(SUM(number_of_purchases * unit_price), 2) AS total_revenue
FROM	games_description gd
JOIN
		games_revenue ON gd.game_id = games_revenue.game_id
GROUP BY game_name
LIMIT 5;



-- Identify the top 3 genres by total revenue
SELECT
		genre,
		FORMAT(SUM(number_of_purchases * unit_price), 2) AS total_revenue
FROM	games_description
JOIN
		games_revenue ON games_description.game_id = games_revenue.game_id
GROUP BY genre
LIMIT 3;




-- Which year generated most of the revenue in the company
SELECT
		game_name,
        year_released,
		FORMAT(SUM(number_of_purchases * unit_price), 2) AS total_revenue
FROM	
		games_description
JOIN
		games_revenue ON games_description.game_id = games_revenue.game_id
GROUP BY 
		game_name, year_released
ORDER BY
		SUM(number_of_purchases * unit_price) DESC;




-- Question 2. Review Percentage
-- Calculate the percentage of customers who left reviews out of the total purchase
SELECT
		gd.game_id,
        gd.game_name,
        gd.genre,
        ROUND((number_of_reviews_from_purchased_people / number_of_purchases) * 100, 2) AS customers_review_percentage
FROM 	
		games_description gd
LEFT JOIN
		games_revenue ON gd.game_id = games_revenue.game_id
LEFT JOIN
		games_reviews ON games_revenue.game_id = games_reviews.game_id
ORDER BY 
		customers_review_percentage DESC;




-- Question 3. English Review Analysis
-- Determine the percentage of reviews written in English for each game
SELECT
		game_name,
        (number_of_english_reviews / number_of_reviews_from_purchased_people) * 100 AS written_in_english_review_percentage
FROM 	
		games_reviews
ORDER BY
		written_in_english_review_percentage DESC;




-- Question 4. Publisher Insights
-- Find the top 5 publishers by total revenue
SELECT
		publisher,
		FORMAT(SUM(number_of_purchases * unit_price), 2) AS total_revenue
FROM	games_description
JOIN
		games_revenue ON games_description.game_id = games_revenue.game_id
GROUP BY 
		publisher
LIMIT 5;




-- Question 5. Engagement Ratios
/*
Calculate the percentage of Helpful and Funny tags to total reviews. 
Which movies and genres have the highest and lowest percentages?
*/

-- helpful
SELECT
		gd.game_name,
        genre,
        (helpful / number_of_reviews_from_purchased_people) * 100 AS helpful_percentage
FROM
		games_reviews
LEFT JOIN
		games_description gd ON games_reviews.game_id = gd.game_id
ORDER BY
		(helpful / number_of_reviews_from_purchased_people) * 100 DESC;




-- funny percentage
SELECT
		gd.game_name,
        genre,
        (funny / number_of_reviews_from_purchased_people) * 100 AS funny_percentage
FROM
		games_reviews
LEFT JOIN
		games_description gd ON games_reviews.game_id = gd.game_id
ORDER BY
		(funny / number_of_reviews_from_purchased_people) * 100 DESC;




/*
Task 4. Advanced SQL: Window Functions
*/
-- Use RANK() to rank games by their total revenue within each genre

SELECT
		gd.genre,
        gd.game_name,
        FORMAT(SUM(gr.number_of_purchases * gr.unit_price), 0) AS total_revenue,
        RANK() OVER (PARTITION BY gd.genre ORDER BY SUM(gr.number_of_purchases * gr.unit_price) DESC) AS revenue_rank
FROM
		games_revenue gr
LEFT JOIN
		games_description gd ON gr.game_id = gd.game_id
GROUP BY
		gd.genre,
        gd.game_name
ORDER BY
		gd.genre,
        revenue_rank;


/*
Adam's suggests reversing the order of the JOIN so that the query starts from games_description instead
*/
SELECT 
		gd.genre, gd.game_name, 
        FORMAT(gr.number_of_reviews_from_purchased_people, 0) AS total_reviews,
		RANK() OVER(PARTITION BY gd.genre ORDER BY gr.number_of_reviews_from_purchased_people DESC) AS review_rank
FROM 
		games_description gd
LEFT JOIN 
		games_reviews gr ON gd.game_id = gr.game_id
ORDER BY 
		gd.genre, review_rank;





-- Use RANK() to rank games by their total reviews within each genre

SELECT
		gd.genre,
        gd.game_name,
        FORMAT(gr.number_of_reviews_from_purchased_people, 0) AS total_reviews,
        RANK() OVER(PARTITION BY gd.genre ORDER BY gr.number_of_reviews_from_purchased_people DESC) AS review_rank
FROM
		games_reviews gr
LEFT JOIN
		games_description gd ON gr.game_id = gd.game_id
ORDER BY
		gd.genre,
        review_rank;


















/*
Task 5. Reporting and Insights
*/



-- PRACTICE

SELECT
		game_name,
        
        SUM(number_of_english_reviews) AS total_reviews,
        
        ROUND(SUM(number_of_english_reviews) / 
        (SELECT SUM(number_of_english_reviews) 
        FROM games_reviews) * 100, 2) AS written_in_english_review_percentage

FROM 	games_reviews

INNER JOIN
		games_revenue ON games_reviews.game_id = games_revenue.game_id
GROUP BY
		game_name
ORDER BY
		SUM(number_of_english_reviews) / 
        (SELECT SUM(number_of_english_reviews) FROM games_reviews) * 100 DESC;


