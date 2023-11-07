require 'rails_helper'

RSpec.describe UsersController, type: :request do
  describe 'GET #index' do
    let!(:user) { User.create(name: 'Kab', photo: 'example.jpg', bio: 'Lorem ipsum') }

    it 'returns a successful response' do
      get users_path
      expect(response).to have_http_status(200)
    end

    it 'assigns @users' do
      get users_path
      expect(assigns(:users)).to eq([user])
    end

    it 'renders the right index template' do
      get users_path
      expect(response).to render_template('index')
    end

    it 'includes correct placeholder text in the response body' do
      get users_path
      expect(response.body).to include('list of all users')
    end
  end

  describe 'GET #show' do
    let!(:user) { User.create(name: 'Kab', photo: 'example.jpg', bio: 'Lorem ipsum') }

    it 'returns a successful response' do
      get user_path(user)
      expect(response).to have_http_status(200)
    end

    it 'assigns @user' do
      get user_path(user)
      expect(assigns(:user)).to eq(user)
    end
    it 'renders the right show template' do
      get user_path(user)
      expect(response).to render_template(:show)
    end

    it 'includes correct placeholder text in the response body' do
      get user_path(user)
      expect(response.body).to include('User Profile')
      expect(response.body).to include('Name: ')
    end
  end
end
