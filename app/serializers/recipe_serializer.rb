# frozen_string_literal: true

class RecipeSerializer
  include JSONAPI::Serializer

  set_id { nil }
  attributes :title, :url, :country, :image
end
