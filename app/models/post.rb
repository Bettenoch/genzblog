class Post < ApplicationRecord
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  belongs_to :author, class_name: 'User', foreign_key: 'author_id', counter_cache: :posts_counter

  after_save :increment_post_counter

  def top_five__comments
    comments.order(created_at: :desc).limit(5)
  end

  # A method to increment the likes_counter attribute.
  # def increment_likes_counter
  #   update(likes_counter: likes_counter + 1)
  # end

  private

  def increment_post_counter
    author.increment!(:posts_counter)
  end
end
