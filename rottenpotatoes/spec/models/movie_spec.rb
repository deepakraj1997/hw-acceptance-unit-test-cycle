require 'rails_helper'
 describe Movie do
  describe '.find_similar_movies' do
    let!(:movie1) { FactoryBot.create(:movie, title: 'Tot', director: 'Jose') }
    let!(:movie2) { FactoryBot.create(:movie, title: 'Molde', director: 'Ole') }
    let!(:movie3) { FactoryBot.create(:movie, title: "ManU", director: 'Steven Spielberg') }
    let!(:movie4) { FactoryBot.create(:movie, title: "Lolpool") }
     context 'director exists' do
      it 'finds similar movies correctly' do
        expect(Movie.similar_movies(movie2.title)).to eql(['Molde', "ManU"])
        expect(Movie.similar_movies(movie1.title)).to eql(['Tot'])
      end
    end
     context 'director does not exist' do
      it 'handles sad path' do
        expect(Movie.similar_movies(movie4.title)).to eql(nil)
      end
    end
  end
end
