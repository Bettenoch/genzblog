require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user) { User.create(name: 'Bett', photo:'https://memyself.com/photos/memyself', bio: 'Greatest man alive', posts_counter: 3) }
  let(:post) {Post.create(author: user, title: 'Amazing skills',text: 'Test post')}

  describe 'Validations' do
    it { should validate_presence_of(:title) }
    it { should validate_length_of(:title).is_at_most(250) }
    it { should validate_numericality_of(:comments_counter).only_integer.is_greater_than_or_equal_to(0) }
    it { should validate_numericality_of(:likes_counter).only_integer.is_greater_than_or_equal_to(0) }
  end

  describe 'Associations' do
    it { should belong_to(:author).class_name('User').with_foreign_key('author_id').counter_cache(:posts_counter) }
    it { should have_many(:comments).dependent(:destroy) }
    it { should have_many(:likes).dependent(:destroy) }
  end

  describe 'Validate Post Input' do
    it 'should have valid attributes' do
        first_post = Post.new(author: user, title: 'Its new', text: 'Shoul display more', likes_counter: 0,
        comments_counter: 0)
        expect(first_post).to be_valid
    end

    it 'Should not exceed 250 chrs' do
        post.title = 'B' * 251
        expect(post).to_not be_valid  
    end

    it 'Should have a title' do
        post.title = ''
        expect(post).to_not be_valid
    end

    it 'Should have integers only' do
      post.comments_counter = 'something' 
      post.likes_counter = 'Something else'

      expect(post).to_not be_valid
    end
  end
  describe 'Methods' do
      it 'returns the top five comments in descending order of creation' do
        # user = User.create(name: 'Ruthless')
        # post = user.posts.create(title: 'Post 1')
    
        comment1 =  post.comments.create(text: 'Comment 1', user_id: user.id, post_id: post.id)
        comment2 = post.comments.create(text: 'Comment 2', user_id: user.id, post_id: post.id)
        comment3 = post.comments.create(text: 'Comment 3', user_id: user.id, post_id: post.id)
        comment4 = post.comments.create(text: 'Comment 4', user_id: user.id, post_id: post.id)
        comment5 = post.comments.create(text: 'Comment 5', user_id: user.id, post_id: post.id)

        top_comments = post.top_five_comments

        expect(top_comments).to eq([comment5, comment4, comment3, comment2, comment1])
      end
  end
end
