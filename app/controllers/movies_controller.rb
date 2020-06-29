class MoviesController < ApplicationController
  before_action :set_movie, only: [:update, :destroy]

  def create
    @movie = Movie.create(movie_params)
    if @movie.valid?
    	render json: @movie
    else
    	render json: {status: "error", code: 400, message: "Something went wrong"}
    end
  end

  def update
    if @movie.update(movie_params)
    	render json: @movie
    else
    	render json: {status: "error", code: 400, message: "Something went wrong"}
    end
  end

  def destroy
   if @movie.destroy
    	render json: {status: "ok", code: 200, message: "Movie deleted successfully"}
    else
    	render json: {status: "error", code: 400, message: "Something went wrong"}
    end
  end

  private

  def movie_params
  	params.permit(:title, :popularity)
  end

  def set_movie
    @movie = Movie.find(params[:id])
  end

end
