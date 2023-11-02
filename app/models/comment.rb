class Comment < ApplicationRecord
  belongs_to :user, class_name: 'User'
  belongs_to :post, counter_cache: :comments_counter, optional: true

  after_save :increment_comments_counter

  private

  def increment_comments_counter
    post.update(comments_counter: post.comments.count)
  end
end
