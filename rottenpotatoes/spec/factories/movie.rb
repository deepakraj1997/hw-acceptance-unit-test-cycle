FactoryBot.define do
  factory :movie do
    title { 'A Fake Title' } # default values
    rating { 'PG' }
    director { 'Fake Director' }
  end
end
