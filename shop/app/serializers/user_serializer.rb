class UserSerializer < ActiveModel::Serializer
  attributes :username, :email, :is_admin
end
