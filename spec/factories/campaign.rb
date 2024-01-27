FactoryBot.define do
  factory :campaign do
    title {Faker::Movie.title}
    description  {Faker::ChuckNorris.fact}
  end
end