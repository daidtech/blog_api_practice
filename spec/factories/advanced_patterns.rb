# FactoryBot Configuration and Best Practices

# This file demonstrates advanced FactoryBot patterns and configurations
# for the blog application

# ================== SEQUENCES ==================
# Use sequences for unique values
FactoryBot.define do
  sequence :email do |n|
    "user#{n}@example.com"
  end

  sequence :title do |n|
    "Blog Post Title #{n}"
  end

  sequence :tag_name do |n|
    "Tag#{n}"
  end
end

# ================== TRAITS ==================
# Use traits for different variations of factories
FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { generate(:email) }

    trait :with_posts do
      after(:create) do |user|
        create_list(:post, 3, user: user)
      end
    end

    trait :active_commenter do
      after(:create) do |user|
        posts = create_list(:post, 2)
        create_list(:comment, 5, user: user, post: posts.sample)
      end
    end

    trait :prolific_writer do
      after(:create) do |user|
        create_list(:post, 10, user: user)
      end
    end
  end

  factory :post do
    title { generate(:title) }
    content { Faker::Lorem.paragraph }
    association :user

    trait :with_many_comments do
      after(:create) do |post|
        create_list(:comment, 5, post: post)
      end
    end

    trait :with_tags do
      after(:create) do |post|
        create_list(:tag, 3, posts: [post])
      end
    end

    trait :popular do
      with_many_comments
      with_tags
    end

    trait :recent do
      created_at { 1.day.ago }
    end

    trait :old do
      created_at { 1.year.ago }
    end
  end
end

# ================== CALLBACK EXAMPLES ==================
# Advanced callback patterns
FactoryBot.define do
  factory :blog_ecosystem do
    # This factory creates a complete blog ecosystem
    initialize_with { new }

    after(:create) do |ecosystem|
      # Create users
      @admin = create(:user, name: "Admin User", email: "admin@blog.com")
      @writers = create_list(:user, 3, :with_posts)
      @commenters = create_list(:user, 5, :active_commenter)

      # Create tags
      @programming_tags = create_list(:tag, 5) do |tag, i|
        tag.name = ["Ruby", "Rails", "JavaScript", "React", "Python"][i]
      end

      # Create featured posts
      @featured_posts = create_list(:post, 3, :popular, user: @admin)

      # Add tags to posts
      @featured_posts.each do |post|
        post.tags << @programming_tags.sample(2)
      end
    end
  end
end

# ================== INHERITANCE EXAMPLES ==================
# Factory inheritance patterns
FactoryBot.define do
  factory :base_user, class: 'User' do
    name { Faker::Name.name }
    email { generate(:email) }
  end

  factory :admin_user, parent: :base_user do
    name { "Admin #{Faker::Name.last_name}" }
    email { "admin+#{SecureRandom.hex(4)}@blog.com" }

    after(:create) do |user|
      # Admin gets special posts
      create_list(:post, 5, user: user, title: "Admin: #{Faker::Lorem.sentence}")
    end
  end

  factory :guest_user, parent: :base_user do
    name { "Guest #{Faker::Name.first_name}" }
    email { "guest+#{SecureRandom.hex(4)}@blog.com" }
  end
end

# ================== ASSOCIATIONS WITH STRATEGY ==================
# Different association strategies
FactoryBot.define do
  factory :comment_with_context do
    content { Faker::Lorem.sentence }

    # Build associations instead of creating them
    association :user, strategy: :build
    association :post, strategy: :build

    after(:build) do |comment|
      # Ensure the post belongs to a different user than the commenter
      if comment.post.user == comment.user
        comment.post.user = build(:user)
      end
    end
  end
end

# ================== TRANSIENT ATTRIBUTES ==================
# Using transient attributes for flexible factory configuration
FactoryBot.define do
  factory :discussion_thread do
    # Transient attributes don't get set on the model
    transient do
      users_count { 3 }
      posts_per_user { 2 }
      comments_per_post { 3 }
      tags_pool { 5 }
    end

    after(:create) do |thread, evaluator|
      # Create users
      users = create_list(:user, evaluator.users_count)

      # Create tags pool
      tags = create_list(:tag, evaluator.tags_pool)

      # Create posts for each user
      users.each do |user|
        posts = create_list(:post, evaluator.posts_per_user, user: user)

        posts.each do |post|
          # Add random tags
          post.tags << tags.sample(rand(1..3))

          # Add comments from other users
          commenting_users = users - [user]
          create_list(:comment, evaluator.comments_per_post,
                     post: post,
                     user: commenting_users.sample)
        end
      end
    end
  end
end

# ================== PERFORMANCE OPTIMIZATION ==================
# Factories optimized for performance
FactoryBot.define do
  factory :lightweight_user do
    # Minimal user for performance tests
    name { "User" }
    email { generate(:email) }

    # Skip callbacks and validations for speed
    to_create { |instance| instance.save(validate: false) }
  end

  factory :bulk_data do
    transient do
      users_count { 100 }
      posts_count { 500 }
      comments_count { 1000 }
    end

    after(:create) do |bulk, evaluator|
      # Use bulk insert for better performance
      users = build_list(:lightweight_user, evaluator.users_count)
      User.insert_all(users.map(&:attributes))

      user_ids = User.last(evaluator.users_count).pluck(:id)

      posts = build_list(:post, evaluator.posts_count).map do |post|
        post.attributes.merge(user_id: user_ids.sample)
      end
      Post.insert_all(posts)

      post_ids = Post.last(evaluator.posts_count).pluck(:id)

      comments = build_list(:comment, evaluator.comments_count).map do |comment|
        comment.attributes.merge(
          user_id: user_ids.sample,
          post_id: post_ids.sample
        )
      end
      Comment.insert_all(comments)
    end
  end
end
