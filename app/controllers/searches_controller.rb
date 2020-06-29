class SearchesController < ApplicationController
  include HTTParty
  before_action :search_local_movies

  # Established the Base URI here and included the api key, hidden in secret credential file
  BASE_URI = 'https://api.themoviedb.org/3/search/movie?api_key=' + Rails.application.credentials.dig(Rails.env.to_sym, :movie_api, :access_key) + '&language=en-US&include_adult=false&query='
	
  # Index method. This will handle the search requests
  def index
  	# We want to make sure there's a search param present
  	return false if params["search"].blank?

	# Store Record of search string & check if duplicate
	search = Search.create(search_text: params["search"])
	unless search.valid?
	  render json: {status: "error", code: 400, message: "This is a duplicate search"}
	  return false
	end

	# Making a get request with HTTParty to the API with the string search param.
	response = HTTParty.get(BASE_URI + params["search"])

	# API results + local results
	@movies = response["results"] + @movies

	# We don't need the extra information, only title and popularity
	@movies.map! {|movie| {title: movie["title"], popularity: movie["popularity"]}}

	# Sort if requested
	sort_movies if params[:sort]

	render json: JSON.pretty_generate(@movies)
  end

  private

  def sort_movies
	@movies = @movies.sort_by {|movie| movie[:popularity]}
  end

  def search_local_movies
  	@movies = Movie.where("title like ?", "%#{params["search"]}%")
  	return [] if @movies.empty?
  end
end
