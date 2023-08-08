FactoryBot.define do
  factory :favorite do
    user
    country { "Thailand" }
    recipe_link { "https://www.example.com/recipe" }
    recipe_title { "Delicious Thai Dish" }
    created_at { Time.now }
  end
end