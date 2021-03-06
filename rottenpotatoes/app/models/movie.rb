class Movie < ActiveRecord::Base
  def self.find_similar_movies movie_title
    director = Movie.find_by(title: movie_title).director
    if director.nil? or director.empty? 
	return nil 
    end
    Movie.where(director: director)
  end
end
