class CommentSerializer < ActiveModel::Serializer
  attributes :id, :text
  belongs_to :post
  belongs_to :user, class_name: 'User'
end
