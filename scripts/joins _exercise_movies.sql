-- 1. Give the name, release year, and worldwide gross of the lowest grossing movie.

SELECT specs.film_title, specs.release_year, revenue.worldwide_gross
FROM specs
INNER JOIN revenue
ON specs.movie_id = revenue.movie_id
ORDER BY worldwide_gross ASC;

--Answer: Semi-Tough 1977 37,187,139

-- 2. What year has the highest average imdb rating?

SELECT specs.release_year, AVG(rating.imdb_rating)
FROM specs
INNER JOIN rating
ON specs.movie_id = rating.movie_id
GROUP BY specs.release_year
ORDER BY AVG(rating.imdb_rating) DESC;

--Answer: 1991

-- 3. What is the highest grossing G-rated movie? Which company distributed it? 

SELECT specs.film_title, specs.mpaa_rating, revenue.worldwide_gross, distributors.company_name
FROM specs
INNER JOIN revenue
ON specs.movie_id = revenue.movie_id
INNER JOIN distributors
ON distributors.distributor_id = specs.domestic_distributor_id
WHERE specs.mpaa_rating = 'G'
ORDER BY revenue.worldwide_gross DESC;

--Answer: Toy Story 4 and Walt Disney

-- 4. Write a query that returns, for each distributor in the distributors table, the distributor name and the number of movies associated with that distributor in the movies 
-- table. Your result set should include all of the distributors, whether or not they have any movies in the movies table.

SELECT DISTINCT distributors.company_name, COUNT(specs.film_title)
FROM distributors
FULL JOIN specs
ON distributors.distributor_id = specs.domestic_distributor_id
GROUP BY distributors.company_name;

-- 5. Write a query that returns the five distributors with the highest average movie budget.

SELECT distributors.company_name, AVG(revenue.film_budget)
FROM distributors
INNER JOIN specs
ON specs.domestic_distributor_id = distributors.distributor_id
INNER JOIN revenue
ON revenue.movie_id = specs.movie_id
GROUP BY distributors.company_name
ORDER BY AVG(revenue.film_budget) DESC
LIMIT 5;

-- 6. How many movies in the dataset are distributed by a company which is not headquartered in California? Which of these movies has the highest imdb rating?

SELECT distributors.company_name, distributors.headquarters, COUNT(specs.film_title), rating.imdb_rating,
FROM distributors
INNER JOIN specs
ON specs.domestic_distributor_id = distributors.distributor_id
INNER JOIN rating
ON rating.movie_id = specs.movie_id
WHERE distributors.headquarters <> '%CA'
GROUP BY distributors.company_name;







