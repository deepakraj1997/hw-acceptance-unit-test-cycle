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
     #it 'Call Movie.similar_movies' do
     #  get :search, { title: 'Star Wars' }
     #  expect(Movie).to receive(:find_similar_movies).with('Star Wars')
     #end
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

end




