class User < ApplicationRecord
  has_many :posts, foreign_key: :author_id, dependent: :destroy, counter_cache: true
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy

  # attribute :name, :string
  # attribute :photo, :string
  # attribute :bio, :text
  # attribute :post_counter, :integer, default: 0

  def top_three_recent_posts
    posts.order(created_at: :desc).limit(3)
  end
end
