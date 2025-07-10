FactoryBot.define do
  factory :post_tag do
    association :post
    association :tag

    # Factory for specific post-tag combinations
    factory :ruby_post_tag do
      association :post, factory: :ruby_post
      association :tag, factory: :ruby_tag
    end

    factory :rails_post_tag do
      association :post, factory: :rails_post
      association :tag, factory: :rails_tag
    end
  end
end
