-- 1. Give the name, release year, and worldwide gross of the lowest grossing movie.
select s.film_title, s.release_year, r.worldwide_gross
from specs as s
inner join revenue as r
using (movie_id)
order by r.worldwide_gross 
limit 1;

--Answer: Semi-Tough (1977)- $37,157,139

-- 2. What year has the highest average imdb rating?
select s.release_year, avg(r.imdb_rating)
from specs as s
inner join rating as r
using (movie_id)
group by s.release_year 
order by avg(r.imdb_rating) desc;

--Answer: 1991, 7.45

-- 3. What is the highest grossing G-rated movie? Which company distributed it?
select s.film_title,
		s.mpaa_rating,
		r.worldwide_gross,
		d.company_name
from specs as s
inner join revenue as r
using (movie_id)
inner join distributors as d
on s.domestic_distributor_id = d.distributor_id
where s.mpaa_rating='G'
order by r.worldwide_gross desc;

--Answer: Toy Story 4 distributed by Walt Disney

-- 4. Write a query that returns, for each distributor in the distributors table, the distributor name and the number of movies associated with that distributor in the movies table. Your result set should include all of the distributors, whether or not they have any movies in the movies table.
select distinct d.company_name,
		count(s.film_title)
from distributors as d
left join specs as s
on d.distributor_id = s.domestic_distributor_id
group by d.company_name;
--Answer

-- 5. Write a query that returns the five distributors with the highest average movie budget.
--Answer

-- 6. How many movies in the dataset are distributed by a company which is not headquartered in California? Which of these movies has the highest imdb rating?
--Answer

-- 7. Which have a higher average rating, movies which are over two hours long or movies which are under two hours?
--Answer
