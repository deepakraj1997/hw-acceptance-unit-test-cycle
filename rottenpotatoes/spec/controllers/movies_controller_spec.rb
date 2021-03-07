require 'rails_helper'

if RUBY_VERSION>='2.6.0'
  if Rails.version < '5'
    class ActionController::TestResponse < ActionDispatch::TestResponse
      def recycle!
        # hack to avoid MonitorMixin double-initialize error:
        @mon_mutex_owner_object_id = nil
        @mon_mutex = nil
        initialize
      end
    end
  else
    puts "Monkeypatch for ActionController::TestResponse no longer needed"
  end
end

describe MoviesController do
 describe 'search movies with same director' do
     it 'Call Movie.similar_movies' do
      get :search, { title: 'Star Wars' }
      res = []
      Movie.find_similar_movies('Star Wars').each { |mov| res.append(mov.director) }
      puts(Movie.find_similar_movies('Star Wars').class)
      expect(res.to_set).to eq(["George Lucas"].to_set)
     end
     it 'Call Movie.similar_movies 2' do
       get :search, { title: 'Star Wars' }
       expect(response).to have_http_status(:ok)
     end
     it "Redirect to root page if director is unknown" do
      get :search, { title: 'The Incredibles' }
      puts(root_url)
      expect(response).to redirect_to(root_url)
     end
 end
 describe 'GET new' do
    let!(:movie) { Movie.new }
     it 'should render the new template' do
      get :new
      expect(response).to render_template('new')
    end
 end
 describe 'Index Page' do
    let!(:movie) {FactoryBot.create(:movie)}
     it 'Home Page' do
      get :index
      expect(response).to render_template('index')
    end
 end
 describe 'Show Page' do
    let!(:movie) { FactoryBot.create(:movie) }
    before(:each) do
      get :show, id: movie.id
    end
     it 'Show Page' do
      expect(response).to render_template('show')
    end
 end
 describe 'After clicking Create' do
    it 'Should be in Index Page' do
     post :create, movie: FactoryBot.attributes_for(:movie)
     expect(response).to redirect_to(movies_url)
    end
 end
 
end




