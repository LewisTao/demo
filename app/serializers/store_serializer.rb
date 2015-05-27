class StoreSerializer < ActiveModel::Serializer
  attributes :id, :name, :address, :description, :image, :category_id, :open_time

  has_one :user, serializer: UserInStoreSerializer
end
