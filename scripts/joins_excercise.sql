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

-- 5. Write a query that returns the five distributors with the highest average movie budget.
select avg(r.film_budget) as avg_film_budget,
		d.company_name		
from specs as s
inner join distributors as d
on s.domestic_distributor_id = d.distributor_id
inner join revenue as r
on s.movie_id = r.movie_id
group by distinct d.company_name
order by avg(r.film_budget) desc
limit 5; 
--Answer: Walt Disney, Sony Pictures, Lionsgate, DreamWorks, Warner Bros.

-- 6. How many movies in the dataset are distributed by a company which is not headquartered in California? Which of these movies has the highest imdb rating?
select count(s.film_title)
from specs as s
inner join distributors as d
on s.domestic_distributor_id = d.distributor_id
where d.headquarters not ilike '%%%CA';
--Answer: 2

select  s.film_title,
		r.imdb_rating
from specs as s
inner join rating as r
using (movie_id)
inner join distributors as d
on s.domestic_distributor_id = d.distributor_id
where d.headquarters not ilike '%%%CA'
group by s.film_title, r.imdb_rating
order by r.imdb_rating desc;
--Answer: Dirty Dancing, 7.0


-- 7. Which have a higher average rating, movies which are over two hours long or movies which are under two hours?
select avg(imdb_rating) as avg_imdb_rating, length_in_min>=120 as over_120_mins, length_in_min<120 as under_120_mins
from rating
inner join specs
using (movie_id)
group by length_in_min>=120,length_in_min<120;
--Answer: Movies under 120 minutes/2 hours
