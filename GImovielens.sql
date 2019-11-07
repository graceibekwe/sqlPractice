CREATE DATABASE movielens; 
USE movielens; 
source C:\Users\Admin\Downloads\movielens.sql; 

QUESTION 1 

SELECT name FROM genres
    -> WHERE id = (
    -> SELECT genre_id FROM genres_movies GROUP BY genre_id
    -> ORDER BY COUNT(genre_id) DESC
    -> LIMIT 1) ;


QUESTION 2

SELECT name FROM occupations
    -> WHERE id = (SELECT MAX(occupation_id) FROM (
    -> SELECT * FROM (
    -> SELECT user_id, movie_id, genre_id, occupation_id FROM (
    -> SELECT user_id, r.movie_id, genre_id FROM ratings r
    -> INNER JOIN genres_movies gm ON r.movie_id = gm.movie_id) AS user_genre_ratings
    -> INNER JOIN users u ON user_genre_ratings.user_id = u.id ) AS user_horror_ratings
    -> WHERE genre_id = (SELECT id FROM genres WHERE name = 'Horror')
    -> GROUP BY occupation_id
    -> ORDER BY COUNT(occupation_id) DESC
    -> LIMIT 1
    -> ) AS uhr
    -> );



QUESTION 3

SELECT occupation_id, COUNT(occupation_id) FROM (
    -> SELECT occupation_id FROM ratings r
    -> INNER JOIN users u ON r.user_id = u.id
    -> ) AS occ_ratings GROUP BY occupation_id;



QUESTION 4

SELECT title FROM movies
    -> WHERE id = (
    -> SELECT movie_id FROM ratings GROUP BY movie_id
    -> ORDER BY COUNT(movie_id) DESC
    -> LIMIT 1);
