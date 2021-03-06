class Movie < ActiveRecord::Base
  def self.find_similar_movies movie_title
    director = Movie.find_by(title: movie_title).director
    if director.nil? 
	    return nil 
    end
    Movie.where(director: director).pluck(:title)
  end
end
