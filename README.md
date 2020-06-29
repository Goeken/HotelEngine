# Movie API Search
***
#### Overview
  - For this challenge I used https://developers.themoviedb.org API for access to millions of movies and TV shows.
  - Rails application was created using --api flag
  - Database contains `Search` and `Movie` Tables
  - The `Search` Table records all searches. I added a unique check to make sure each search is unique.
  - If a search is not unique then an error message is returned.
  - You can add a string to the search and all matches will be returned
  - You can add sort to the query to sort by popularity
  - For the Movie Model You can add movies to be included in the search.
  - All basic CRUD operations can be used on the Movie model.
  - If any movies are added to the Movies Table they are added to the search
  - Included Tests for the movie Model
  - Deployed Application to Heroku for easy access

***

#### Example Search
You can connect to the API by using CURL

Request
```sh
$ curl 'http://localhost:3000/searches?search=avengers'
```
Response
```sh
[
  {
    "title": "Avengers: Infinity War",
    "popularity": 105.431
  },
  {
    "title": "Avengers: Endgame",
    "popularity": 63.349
  },
  ...
```
#### Adding sort
By adding `sort=true` you can sort by popularity

Request
```sh
$ curl 'http://localhost:3000/searches?search=avengers&sort=true'
```
Response
```sh
[
  {
    "title": "Matrix",
    "popularity": 0.62
  },
  {
    "title": "Matrix",
    "popularity": 0.64
  },
  {
    "title": "Matrix III",
    "popularity": 1.083
  },
  {
    "title": "Making 'The Matrix'",
    "popularity": 1.098
  },
  {
    "title": "V-World Matrix",
    "popularity": 1.4
  },
  ...
```
#### Creating a Movie
Request
```sh
$ curl -d "title=summer time&popularity=15" -X POST 'http://localhost:3000/movies'
```
Response
```sh
{"id":8,"title":"summer time","popularity":15,"created_at":"2020-06-29T04:24:45.925Z","updated_at":"2020-06-29T04:24:45.925Z"}
```
#### Updating a Movie
Request
```sh
$ curl -d "title=Mid July&popularity=15" -X PUT 'http://localhost:3000/movies/8'
```
Response
```sh
{"id":8,"title":"Mid July","popularity":15,"created_at":"2020-06-29T04:24:45.925Z","updated_at":"2020-06-29T04:27:43.611Z"}
```
#### Deleting a Movie
Request
```sh
$ curl -X DELETE 'http://localhost:3000/movies/8'
```
Response
```sh
{"status":"ok","code":200,"message":"Movie deleted successfully"}
```
