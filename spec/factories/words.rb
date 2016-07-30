FactoryGirl.define do
  factory :word do
    # sequence(:word) { |i| "word #{i}" }
    # sequence(:meaning) { |i| "meaning explaining the word with index #{i}" }
    # example(:example) { |i| "here comes a few examples of the word #{i}" }
    language 0
    active true

    trait :portuguese do
      language 1
    end

    trait :inactive do
      active false
    end
  end
end
