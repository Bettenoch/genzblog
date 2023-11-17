class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  has_many :posts, foreign_key: :author_id, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy

  # validations
  validates :name, presence: true
  validates :posts_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :role, inclusion: { in: %w[admin user], message: '%<value>s is not a valid role [admin, user]' }

  # Set default post counter to 0
  before_create :default_posts_counter

  def top_three_recent_posts(limit = 3)
    posts.order(created_at: :desc).limit(limit)
  end

  def default_posts_counter
    posts_counter || 0
  end

  def is?(requested_role)
    role == requested_role.to_s
  end
end
