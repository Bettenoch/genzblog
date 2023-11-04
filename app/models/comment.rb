class Comment < ApplicationRecord
  belongs_to :user, class_name: 'User'
  belongs_to :post, counter_cache: :comments_counter, optional: true

  after_save :increment_comments_counter

  validates :text, presence: true
  validates :user, presence: true
  validates :post, presence: true

  def increment_comments_counter
    post.increment!(:comments_counter)
  end
end
