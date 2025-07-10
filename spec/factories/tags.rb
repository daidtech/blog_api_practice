FactoryBot.define do
  factory :tag do
    name { Faker::ProgrammingLanguage.name }

    # Named factories for specific test tags
    factory :ruby_tag do
      name { "Ruby" }
    end

    factory :rails_tag do
      name { "Rails" }
    end

    factory :javascript_tag do
      name { "JavaScript" }
    end

    factory :react_tag do
      name { "React" }
    end

    factory :python_tag do
      name { "Python" }
    end

    factory :vue_tag do
      name { "Vue" }
    end

    # Factory for tag with posts
    factory :tag_with_posts do
      transient do
        posts_count { 2 }
      end

      after(:create) do |tag, evaluator|
        posts = create_list(:post, evaluator.posts_count)
        tag.posts = posts
      end
    end
  end
end
