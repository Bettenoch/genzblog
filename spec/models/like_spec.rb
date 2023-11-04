require 'rails_helper'

RSpec.describe Like, type: :model do
  let(:user) { User.create(name: 'Bett', photo: 'https://memyself.com/photos/memyself', bio: 'Greatest man alive', posts_counter: 3) }
  let(:post) { Post.create(author: user, title: 'Amazing skills', text: 'Test post') }

  describe 'validations' do
    it 'is valid with valid attributes' do
      like = Like.new(user:, post:)
      expect(like).to be_valid
    end

    it 'is not valid without a user' do
      like = Like.new(post:)
      expect(like).not_to be_valid
      expect(like.errors[:user]).to include("can't be blank")
    end

    it 'is not valid without a post' do
      like = Like.new(user:)
      expect(like).not_to be_valid
      expect(like.errors[:post]).to include("can't be blank")
    end

    it 'is not valid if a user likes the same post multiple times' do
      Like.create(user:, post:) # Create the first like
      like = Like.new(user:, post:)
      expect(like).not_to be_valid
      expect(like.errors[:user_id]).to include('You can only like a post once.')
    end
  end
end
