class Post < ApplicationRecord
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  belongs_to :author, class_name: 'User', foreign_key: 'author_id', counter_cache: :posts_counter

  after_save :increment_post_counter

  # validations
  validates :title, presence: true, length: { maximum: 250 }
  validates :comments_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :likes_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def top_five_comments(limit = 5)
    comments.order(created_at: :desc).limit(limit)
  end

  # A method to increment the likes_counter attribute.
  # def increment_likes_counter
  #   update(likes_counter: likes_counter + 1)
  # endn

  def increment_post_counter
    author.increment!(:posts_counter) if author.present?
  end
end
