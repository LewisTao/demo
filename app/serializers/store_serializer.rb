class StoreSerializer < ActiveModel::Serializer
  attributes :id, :name, :address, :description, :open_time
end
