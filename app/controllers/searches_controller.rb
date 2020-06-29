class SearchesController < ApplicationController
  # HTTParty is my favorite gem for retrieving data over the web
  include HTTParty
  # Established the Base URI here and included the api key, hidden in secret credential file
  BASE_URI = 'https://api.themoviedb.org/3/search/movie?api_key=' + Rails.application.credentials.dig(:movie_api, :access_key) + '&language=en-US&include_adult=false&query='
	
  # Index method. This will handle the search requests
  # Allows search string and filter
  def index
    # We want to make sure there's a search param present
	return false unless params["search"]

	# Store Record of search string & check if duplicate
	search = Search.create(search_text: params["search"])
	if !search.valid?
		render json: { :error => "This search is a duplicate" }
		return false
	end

	# Making a request with HTTParty to the Base uri and the string for the search.
	response = HTTParty.get(BASE_URI + params["search"])
	@movies = response["results"]
	# We don't need all the extra information that the API provides, only title and popularity of movie
	@movies.map! {|movie| {title: movie["title"], popularity: movie["popularity"]}}
	# Sort if requested
	sort_movies if params[:sort]

	# Return movies
	#put this in a concern
	render json: JSON.pretty_generate(@movies)
  end

  private

  def sort_movies
	return @movies = @movies.sort_by {|movie| movie[:popularity]}
  end
end
