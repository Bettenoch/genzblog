class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post, counter_cache: :likes_counter

  after_save :increment_likes_counter

  private

  def increment_likes_counter
    post.update(likes_counter: post.likes.count)
  end
end
