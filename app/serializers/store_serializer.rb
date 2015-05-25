class StoreSerializer < ActiveModel::Serializer
  attributes :id, :name, :address, :description, :open_time, :image

  has_one :user, serializer: UserInStoreSerializer
end
