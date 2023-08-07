class FavoriteSerializer
  include JSONAPI::Serializer
  attributes :country, :recipe_link, :recipe_title

  belongs_to :user
end