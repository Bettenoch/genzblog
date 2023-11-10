class Post < ApplicationRecord
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'

  after_save :increment_post_counter

  # validations
  validates :title, presence: true, length: { maximum: 250 }
  validates :comments_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :likes_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def top_five_comments(limit = 5)
    comments.order(created_at: :desc).limit(limit)
  end

  def increment_post_counter
    author.update(posts_counter: author.posts.count) if author.present?
  end
end
