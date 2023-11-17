class Comment < ApplicationRecord
  belongs_to :user, class_name: 'User', foreign_key: :user_id
  belongs_to :post

  after_save :increment_comments_counter
  after_destroy :increment_comments_counter

  validates :text, presence: true
  validates :user, presence: true
  validates :post, presence: true

  def increment_comments_counter
    post.update(comments_counter: post.comments.count)
  end
end
