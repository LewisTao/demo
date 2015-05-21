class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :auth_token, :admin

  has_many :stores, embed: :ids
end
