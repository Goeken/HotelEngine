require 'rails_helper'

RSpec.describe MoviesController, type: :controller do

  # create action
  describe 'POST #create' do
    it 'creates a movie' do 
      movie = Movie.create(title: "avengers", popularity: 3)
      expect(movie.title).to eq('avengers')
      expect(movie.popularity).to eq(3)
    end 
  end

  # edit action
  describe 'PATCH #update' do
    it 'updates a movie' do
      movie = Movie.create(title: "avengers", popularity: 3)
      movie.update(title: "snowman", popularity: 5)
      expect(movie.title).to eq('snowman')
      expect(movie.popularity).to eq(5)
    end
  end

  # delete action
  describe 'DELETE #delete' do
    it 'deletes a movie' do
      movie = Movie.create(title: "avengers", popularity: 3)
      movie.destroy
	  expect { movie.reload }.to raise_error ActiveRecord::RecordNotFound
    end
  end

end