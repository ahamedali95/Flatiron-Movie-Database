# Flatiron Movie Database CLI Program - Data Analytics Project

This program is a Ruby command line interface program built to query information about movies. It utilizes the OMDB API to query movie details based on an user's search term and stores the collected data in a SQLite3 database. The data records are then accessed through ActiveRecord and converted to Ruby objects before displaying results to the user. This program implements the core concept of relational database as a foundation to relate data to one another so that information can be efficiently retrieved. The relationships are formed using ActiveRecord associations. This program also utilizes Rake tool to effectively manage the database changes(migration, seed, rollback, etc..).

## Entity Relationship Diagram:
![untitled diagram xml draw io](https://user-images.githubusercontent.com/24445922/39028854-e55e380c-4426-11e8-88cf-d2ab005d6b76.png)


## Database Schema:
### directors:  <br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1. id - primary key field <br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2. name <br />
### directed_movies: <br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1. id - primary key field <br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2. director_id - foreign key field references the primary key field of id in directors <br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;3. movie_id - foreign key field references the primary key field of id in movies <br />
### movies: <br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1. id - primary key field <br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2. title <br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;3. year <br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;4. rated <br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;5. released ... <br />
### casts: <br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1. id - primary key field <br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2. movie_id - foreign key field references the primary key field of id in movies <br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;3. actor_id - foreign key field references the primary key field of id in actors <br />
### actors: <br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1. id - primary key field <br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2. name <br />

## Query Operations:
		1a. See Available movies within database
				-queries all the movie titles from the database
			b. See available actors.
				-queries all the actors from the database
			c. See available directors.
				-queries all the directors from the database
		2. Search available movies online
		    	-queries the movie from the existing database, if found, displays the information. If not, the program makes an API to get the information and seed it to the database
		3. Search movies by actor
		-queries all the actors from the database and gives the user the option to get a list all movies that casts a particular actor provided by the user
		4. Search movies by director
			  -queries all the directors from the database and gives the user the option to get a list all movies directed by a particular director provided by the user
		6. Top 3 rated movies within our current database.
			-queries all the movie titles and IMDB ratings of top three movies from the database
		7. Top 3 Box Office movies within db
		-queries all the movie titles and box office collection of top three movies from the database
		8. Find movies by MPAA Rating
		      -queries all the parental ratings from the database and gives the user the option to get all movies based on a rating provided by the user.
		9. Look up movie by decade
		      -queries all movies that are released in a decade provided by the user
		10. Look up movies by studio
		      -queries all the studios from the database and gives the user the option to get all movies based on a studio name provided by the user

**Note: Since OMDB API allows to make a query using only movie title, a short list of movies' information are pre-seeded to the database so that the user can query the movie information from the existing database as well as query a movie that is not currently in the database by only movie title. Any movie that is newly queried will be automatically seeded in to the database.**

##### DEMO
[![watch this video](https://img.youtube.com/vi/vSlspIAvtaI/0.jpg)](https://youtu.be/vSlspIAvtaI)
