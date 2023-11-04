require 'rails_helper'

RSpec.describe User, type: :model do
  subject { User.new(name: 'King') }

  before { subject.save }
  
  describe 'Validations' do
    it { should validate_presence_of(:name) }
    it { should validate_numericality_of(:posts_counter).only_integer.is_greater_than_or_equal_to(0) }
  end

  describe 'Associations' do
    it { should have_many(:posts).dependent(:destroy) }
    it { should have_many(:likes).dependent(:destroy) }
    it { should have_many(:comments).dependent(:destroy) }
  end

  describe 'Methods' do
    describe '#top_three_recent_posts' do
      let(:user) { create(:user) }
      it 'returns the top three recent posts' do
        user = User.create(name: 'Ruthless')

        post1 = Post.create(title: 'Post 1', author: user, created_at: 4.days.ago)
        post2 = Post.create(title: 'Post 2', author: user, created_at: 3.days.ago)
        post3 = Post.create(title: 'Post 3', author: user, created_at: 2.days.ago)
        post4 = Post.create(title: 'Post 4', author: user, created_at: 5.days.ago)

        top_posts = user.top_three_recent_posts

        expect(top_posts).to eq([post3, post2, post1])
      end
    end
  end
end
