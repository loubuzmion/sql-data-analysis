
-- SELECT Merge of All Three Tables

SELECT 
    d.game_id,
    d.game_name,
    d.year_released,
    d.publisher,
    d.genre,
    r.Number_of_Purchases,
    r.Unit_Price,
    v.number_of_reviews_from_purchased_people,
    v.number_of_english_reviews,
    v.Hours_Played,
    v.Helpful,
    v.Funny
FROM games_description d
LEFT JOIN games_revenue r
    ON d.game_id = r.game_id
LEFT JOIN games_reviews v
    ON d.game_id = v.game_id;


-- Create a New Combined Table

CREATE TABLE games_combined AS
SELECT 
    d.game_id,
    d.game_name,
    d.year_released,
    d.publisher,
    d.genre,
    r.Number_of_Purchases,
    r.Unit_Price,
    v.number_of_reviews_from_purchased_people,
    v.number_of_english_reviews,
    v.Hours_Played,
    v.Helpful,
    v.Funny
FROM games_description d
LEFT JOIN games_revenue r
    ON d.game_id = r.game_id
LEFT JOIN games_reviews v
    ON d.game_id = v.game_id;


-- Validate the Merge

SELECT 
    COUNT(*) AS total_rows,
    COUNT(r.game_id) AS revenue_matches,
    COUNT(v.game_id) AS review_matches
FROM games_description d
LEFT JOIN games_revenue r ON d.game_id = r.game_id
LEFT JOIN games_reviews v ON d.game_id = v.game_id;

