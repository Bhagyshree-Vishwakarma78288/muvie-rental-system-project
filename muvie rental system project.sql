-- movie rental system 
-- create database
create database movie_rental; 
use movie_rental; 

drop table if exists movie;
-- create tables rentals,customers,movie,genres

create table genres(
genre_id int auto_increment primary key,
genre_name varchar(125) not null);

create table movie(
movie_id int auto_increment primary key,
title varchar(110) not null,
genre_id int not null,
release_year year not null,
directore int not null,
language varchar(75) not null,
duretion int not null,
foreign key (genre_id) references genres (genre_id));

alter table movie modify directore varchar(125);

create table customers(
customers_id int auto_increment primary key,
first_name varchar(75) not null,
last_name varchar(85) not null,
email varchar(124) not null,
gender varchar(70) not null,
dob date not null,
phone_number varchar(45) not null);

create table rentals(
rental_id int auto_increment primary key,
movie_id int not null,
customers_id int,
rental_date date not null,
return_date date not null); 

alter table rentals add foreign key (movie_id) references movie(movie_id) ; 
alter table rentals add foreign key (customers_id) references customers(customers_id);

-- insert data
insert into genres values(
01,('Action'));

insert into genres values(
02, ('Comedy'));

insert into genres values(
03,('Drama'));

insert into genres values(
04,('Horror'));

insert into genres values(
05, ('Sci-Fi'));

insert into movie values(
001,'The Matrix', 01, 1999, 'Wachowski_Brothers', 'English', 136); 

insert into movie values(
002,'The Godfather',02, 1972, 'Francis Ford Coppola', 'English', 175); 

insert into movie values(
003,'Toy Story', 03, 1995, 'John Lasseter', 'English', 81);

insert into movie values(
004,'Jaws', 04, 1975, 'Steven Spielberg', 'English', 124);

insert into movie values(
005,'Die Hard', 05, 1988, 'John McTiernan', 'English', 132);

select * from movie;

update movie
set genre_id = 03
where movie_id = 003;

update movie
set genre_id = 05
where movie_id = 005;

insert into customers values(
1001,'John', 'Doe', 'john.doe@example.com', 'Male', '1985-05-15', '9876543210');

insert into customers values(
1002,'Jane', 'Smith', 'jane.smith@example.com', 'Female', '1990-10-25', '8765432109');

insert into customers values(
1003,'Alice', 'Johnson', 'alice.johnson@example.com', 'Female', '1995-07-03', '7654321098');

insert into customers values(
1004,'Bob', 'Brown', 'bob.brown@example.com', 'Male', '1982-11-10', '6543210987');

insert into customers values(
1005,"shree","vishwakarma","shree8871@gmail.com","Female","1992-10-30","8678454856");

insert into rentals values(
0.01, 001,1001,'2023-01-01','2023-01-05');

insert into rentals values(
0.02,002,1002,'2023-01-02','2023-01-06');

insert into rentals values(
0.03,003,1003,'2023-01-03','2023-01-07'); 

insert into rentals values(
0.04,004,1004,'2023-01-04','2023-01-08'); 

insert into rentals values(
0.05,005,1005,'2023-01-05','2023-01-09');

select * from genres;
select * from movie; 
select * from customers; 
select * from rentals; 

-- Q1  List all movies along with their genres.
select g.genre_id,movie_id,title from movie m 
inner join genres g 
on m.genre_id = g.genre_id; 

-- Q2 Find all movies released after the year 1995.
select * from movie
where release_year = "1995" ;

 -- Q3 List all customers who have rented a movie.
 select concat(first_name," ",last_name) as full_name,c.customers_id, gender from customers c 
 inner join rentals r 
 on c.customers_id = r.customers_id ; 
 
 -- Q4 Find the total number of rentals for each movie.
 select m.title ,count(rental_id) as total_rentls from movie m 
 inner join rentals r 
 on m.movie_id = r.movie_id
 group by m.title; 
 
 -- Q5 List all movies rented by a specific customer (e.g., 'John Doe').
 select m.movie_id , title,language from movie m 
 inner join rentals r 
 on m.movie_id = r.movie_id 
 inner join customers c 
 on r.customers_id = c.customers_id
 where c.first_name = "John" and c.last_name= "Doe"; 
 
 -- Q6 Find the number of movies in each genre.
 select g.genre_name , count(movie_id) as movie_count from genres g 
 join movie m 
 on g.genre_id = m.genre_id
 group by g.genre_name; 
 
 -- Q7 List all customers who rented movies in January 2023
 select c.customers_id,concat(first_name," ",last_name) as full_name from customers c 
 join rentals r 
 on c.customers_id = r.customers_id 
 where r.rental_date between "2023-01-01" and "2023-01-31" ; 
 
 -- Q8 Find the most rented movie
 select m.title, count(rental_id) as retal_count from movie m 
 inner join rentals r 
 on m.movie_id = r.movie_id
 group by m.title 
 order by retal_count desc
 limit 1 ; 
 
 -- Q9 . Get all movies that belong to the 'Comedy' genre.
 select * from genres;
 select * from customers; 
 select * from movie; 
 select * from rentals; 
 select m.title,g.genre_name from movie m  
join genres g 
on m.genre_id = g.genre_id
where g.genre_name = "Comedy"; 

-- Q10 Update the duration of 'Toy Story' to 82 minutes.
update movie 
set duretion = 82 
where movie_id = 3; 

-- Q11 Find all customers who rented movies directed by 'Steven Spielberg'. 
select * from rentals;
select * from customers;
select * from movie; 
select concat(c.first_name," ",c.last_name)as full_name,c.customers_id from customers c  
join rentals r on c.customers_id = r.customers_id 
join movie m on r.movie_id = m.movie_id 
where m.directore = "Steven Spielberg"; 

-- Q12 List all movies along with their genres and directors.
select * from customers; 
select * from movie;
select * from genres; 
select m.title,m.directore,g.genre_name from movie m  
join genres g 
on m.genre_id = g.genre_id ; 

-- Q13 Find the customer who has rented the most movies.
select * from customers; 
select * from rentals; 
select * from movie; 
select distinct first_name,last_name , count(r.rental_id) as rental_count from customers c 
join rentals r 
on c.customers_id = r.customers_id 
group by c.customers_id
order by rental_count desc
limit 1; 

-- Q14 Find all movies that have been rented by 'John Doe'.
select * from movie; 
select * from rentals;
select * from customers; 
select * from movie m 
join rentals r 
on m.movie_id = r.movie_id 
join customers c 
on r.customers_id = c.customers_id 
where first_name = "John" and last_name = "Doe"; 

-- Q15 List all genres and how many movies belong to each genre.
select * from genres;
select * from movie;
select g.genre_name,count(m.movie_id) as total_movie from genres g 
left join movie m 
on g.genre_id = m.genre_id
group by g.genre_name ; 

-- Q16 Find all rentals where the return date is before the rental date.
select * from rentals; 
select rental_date,return_date from rentals 
where return_date < rental_date ; 

-- Q17 Get the list of customers who have rented movies directed by 'Francis Ford Coppola'.
select * from customers; 
select * from rentals; 
select * from movie;
select c.first_name,c.last_name,r.rental_id,r.movie_id from customers c 
join rentals r
on c.customers_id = r.customers_id 
join movie m 
on m.movie_id = r.movie_id 
where directore = 'Francis Ford Coppola';
 
 
 
 
 
 
 
 
 
 
 













 


  





























 




