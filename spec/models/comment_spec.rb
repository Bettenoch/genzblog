require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:user) { User.create(name: 'Bett', photo: 'https://memyself.com/photos/memyself', bio: 'Greatest man alive', posts_counter: 3) }
  let(:post) { Post.create(author: user, title: 'Amazing skills', text: 'Test post') }
  it 'is valid with valid attributes' do
    comment = Comment.new(text: 'A valid comment', user:, post:)
    expect(comment).to be_valid
  end

  it 'is not valid without text' do
    comment = Comment.new(text: nil)
    expect(comment).to_not be_valid
  end

  it 'is not valid without a user' do
    comment = Comment.new(user: nil)
    expect(comment).to_not be_valid
  end

  it 'is not valid without a post' do
    comment = Comment.new(post: nil)
    expect(comment).to_not be_valid
  end

  it 'increments comments_counter on the associated post' do
    comment = Comment.create(text: 'A comment', user:, post:)

    initial_comments_counter = post.comments_counter
    comment.save

    post.reload
    expect(post.comments_counter).to eq(initial_comments_counter)
  end
end
