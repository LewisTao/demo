class StoreSerializer < ActiveModel::Serializer
  attributes :id, :name, :address, :open_time, :description
end
