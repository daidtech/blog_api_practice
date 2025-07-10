FactoryBot.define do
  factory :post do
    title { Faker::Lorem.sentence(word_count: 3) }
    content { Faker::Lorem.paragraph(sentence_count: 5) }
    association :user

    # Named factories for specific test posts
    factory :ruby_post do
      title { "Getting Started with Ruby" }
      content { "Ruby basics tutorial" }
    end

    factory :rails_post do
      title { "Advanced Rails Techniques" }
      content { "Advanced Rails concepts" }
    end

    factory :javascript_post do
      title { "JavaScript for Beginners" }
      content { "JS fundamentals" }
    end

    factory :react_post do
      title { "React Development" }
      content { "React components guide" }
    end

    factory :database_post do
      title { "Database Optimization" }
      content { "SQL optimization tips" }
    end

    # Factory for post with comments
    factory :post_with_comments do
      transient do
        comments_count { 2 }
      end

      after(:create) do |post, evaluator|
        create_list(:comment, evaluator.comments_count, post: post)
      end
    end

    # Factory for post with tags
    factory :post_with_tags do
      transient do
        tags_count { 2 }
      end

      after(:create) do |post, evaluator|
        create_list(:tag, evaluator.tags_count, posts: [post])
      end
    end

    # Factory for post with both comments and tags
    factory :post_with_comments_and_tags do
      transient do
        comments_count { 2 }
        tags_count { 2 }
      end

      after(:create) do |post, evaluator|
        create_list(:comment, evaluator.comments_count, post: post)
        create_list(:tag, evaluator.tags_count, posts: [post])
      end
    end
  end
end
