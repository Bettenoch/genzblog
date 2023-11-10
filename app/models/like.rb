class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post

  after_save :increment_likes_counter

  validates :user, presence: true
  validates :post, presence: true
  validates_uniqueness_of :user_id, scope: :post_id, message: 'You can only like a post once.'

  def increment_likes_counter
    post.increment!(:likes_counter)
  end
end
