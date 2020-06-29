class SearchesController < ApplicationController
	# HTTParty is my favorite gem for retrieving data over the web
	include HTTParty
	# I establish the Base URI here and include the api key, hidden in Rails 5.2 and greater secret credential file
	BASE_URI = 'https://api.themoviedb.org/3/search/movie?api_key=' + Rails.application.credentials.dig(:movie_api, :access_key) + '&language=en-US&include_adult=false&query='
	
	# Index method. This will handle the search requests
	# Allows search string and filters
	def index
		return false unless params["search"]
		# Making a request with HTTParty to the Base uri and anything that is added as a param for the search.
		response = HTTParty.get(BASE_URI + params["search"])
		movie_array = response["results"]
		# We don't need all the extra information that the API provides, only title and popularity of movie
		movie_array.map! {|movie| {title: movie["title"], popularity: movie["popularity"]}}



		render json: movie_array
		 # Rails.logger.debug "\n\n\n#{response}\n\n\n"
	end

end
