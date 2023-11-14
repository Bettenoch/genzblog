require 'rails_helper'

RSpec.describe PostsController, type: :request do
  describe 'GET #index' do
    let(:user) { User.create(name: 'Bett', photo: 'https://memyself.com/photos/memyself', bio: 'Greatest man alive', posts_counter: 3) }
    let(:post) { Post.create(author: user, title: 'Amazing skills', text: 'Test post') }

    it 'returns a successful response' do
      get user_posts_path(user)
      expect(response).to have_http_status(200)
    end

    it 'renders the index template' do
      get user_posts_path(user)
      expect(response).to render_template('index')
    end

    it 'includes correct placeholder text in the response body' do
      get user_posts_path(user)
      expect(response.body).to include('Add Post')
    end
  end

  describe 'GET #show' do
    let(:user) { User.create(name: 'Bett', photo: 'https://memyself.com/photos/memyself', bio: 'Greatest man alive', posts_counter: 3) }
    let(:post) { Post.create(author: user, title: 'Amazing skills', text: 'Test post') }

    it 'returns a successful response' do
      get user_post_path(user, post)
      expect(response).to have_http_status(200)
    end

    it 'renders the show template' do
      get user_post_path(user_id: user, id: post)
      expect(response).to render_template(:show)
    end

    it 'renders the show template' do
      get user_post_path(user, post)
      expect(response).to render_template('show')
    end

    it 'includes correct placeholder text in the response body' do
      get user_post_path(user, post)
      expect(response.body).to include('Comments:')
    end
  end
end
