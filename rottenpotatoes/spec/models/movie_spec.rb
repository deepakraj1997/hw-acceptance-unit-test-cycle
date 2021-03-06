require 'rails_helper'
 describe Movie do
  describe '.find_similar_movies' do
    let!(:movie1) { FactoryBot.create(:movie, title: 'Tot', director: 'Jose') }
    let!(:movie2) { FactoryBot.create(:movie, title: 'Molde', director: 'Ole') }
    let!(:movie3) { FactoryBot.create(:movie, title: "ManU", director: 'Ole') }
    let!(:movie4) { FactoryBot.create(:movie, title: "Lolpool") }
     context 'director exists' do
      it 'finds similar movies correctly' do
	      expect(Movie.find_similar_movies(movie2.title).length).to eql(2)
	      expect(Movie.find_similar_movies(movie1.title).length).to eql(1)
      end
    end
     context 'director does not exist' do
      it 'handles sad path' do
	      expect(Movie.find_similar_movies(movie4.title).length).to eql(1)
      end
    end
  end
end
