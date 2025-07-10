FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.unique.email }

    # Named factories for specific test users
    factory :john_doe do
      name { "John Doe" }
      email { "john@example.com" }
    end

    factory :jane_smith do
      name { "Jane Smith" }
      email { "jane@example.com" }
    end

    factory :bob_wilson do
      name { "Bob Wilson" }
      email { "bob@example.com" }
    end

    # Factory for user with posts
    factory :user_with_posts do
      transient do
        posts_count { 3 }
      end

      after(:create) do |user, evaluator|
        create_list(:post, evaluator.posts_count, user: user)
      end
    end

    # Factory for user with comments
    factory :user_with_comments do
      transient do
        comments_count { 2 }
      end

      after(:create) do |user, evaluator|
        posts = create_list(:post, 2)
        create_list(:comment, evaluator.comments_count, user: user, post: posts.sample)
      end
    end
  end
end
