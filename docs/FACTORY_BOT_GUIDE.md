# FactoryBot Guide for Active Record Challenges

## Setup and Installation

1. **Install required gems:**
   ```bash
   bundle install
   ```

2. **Generate RSpec configuration:**
   ```bash
   rails generate rspec:install
   ```

3. **Run tests:**
   ```bash
   rspec
   ```

## FactoryBot Basics

### Creating Records

```ruby
# Create and save to database
user = create(:user)

# Build in memory (not saved)
user = build(:user)

# Build with stubbed associations (fastest)
user = build_stubbed(:user)

# Create multiple records
users = create_list(:user, 5)
```

### Using Named Factories

```ruby
# Use specific named factories
john = create(:john_doe)
ruby_tag = create(:ruby_tag)
ruby_post = create(:ruby_post, user: john)
```

### Override Attributes

```ruby
# Override factory attributes
user = create(:user, name: "Custom Name", email: "custom@example.com")

# Use with associations
post = create(:post, user: john, title: "Custom Title")
```

## Advanced Patterns

### Traits

```ruby
# Create user with posts
user = create(:user, :with_posts)

# Create popular post (with comments and tags)
post = create(:post, :popular)

# Combine multiple traits
user = create(:user, :with_posts, :active_commenter)
```

### Transient Attributes

```ruby
# Control factory behavior
post = create(:post_with_comments, comments_count: 5)
user = create(:user_with_posts, posts_count: 3)
```

### Associations

```ruby
# Create with specific associations
comment = create(:comment, post: my_post, user: my_user)

# Create with built associations (not saved)
comment = create(:comment,
  post: build(:post),
  user: build(:user)
)
```

## Factory Organization

### Basic Factories

```ruby
# spec/factories/users.rb
FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.unique.email }

    factory :john_doe do
      name { "John Doe" }
      email { "john@example.com" }
    end
  end
end
```

### Factories with Callbacks

```ruby
# spec/factories/posts.rb
FactoryBot.define do
  factory :post do
    title { Faker::Lorem.sentence }
    content { Faker::Lorem.paragraph }
    association :user

    factory :post_with_comments do
      after(:create) do |post|
        create_list(:comment, 3, post: post)
      end
    end
  end
end
```

## Performance Tips

### Use `build_stubbed` for Fast Tests

```ruby
# Fast - no database calls
users = build_stubbed_list(:user, 100)

# Slow - 100 database inserts
users = create_list(:user, 100)
```

### Bulk Creation

```ruby
# Create test data efficiently
factory :bulk_test_data do
  after(:create) do
    # Use Rails bulk insert methods
    User.insert_all([...])
    Post.insert_all([...])
  end
end
```

### Minimize Database Calls

```ruby
# Bad - many database calls
users = create_list(:user, 10)
users.each do |user|
  create_list(:post, 5, user: user)
end

# Better - batch creation
users = create_list(:user, 10)
posts = users.flat_map do |user|
  build_list(:post, 5, user: user)
end
Post.insert_all(posts.map(&:attributes))
```

## Testing Patterns

### Setup Data for Challenges

```ruby
RSpec.describe "ActiveRecord Challenges" do
  # Use let! to create data before each test
  let!(:users) { create_list(:user, 3) }
  let!(:posts) { create_list(:post, 5) }

  # Or use factories with specific data
  let!(:john) { create(:john_doe) }
  let!(:ruby_post) { create(:ruby_post, user: john) }

  it "tests something" do
    # Your test code here
  end
end
```

### Complex Scenarios

```ruby
# Create a complete blog ecosystem
let!(:blog_data) do
  # Create users with different roles
  admin = create(:admin_user)
  writers = create_list(:user, 3, :with_posts)
  commenters = create_list(:user, 5, :active_commenter)

  # Create tags
  tags = create_list(:tag, 5)

  # Create featured content
  featured_posts = create_list(:post, 3, :popular, user: admin)

  # Connect everything
  featured_posts.each do |post|
    post.tags << tags.sample(2)
  end
end
```

## Common Patterns for Challenges

### Level 1-2: Basic Queries

```ruby
# Simple data setup
let!(:users) { create_list(:user, 5) }
let!(:posts) { create_list(:post, 10) }
```

### Level 3-4: Associations

```ruby
# Data with associations
let!(:users_with_posts) { create_list(:user, 3, :with_posts) }
let!(:posts_with_comments) { create_list(:post, 5, :with_many_comments) }
```

### Level 5-6: Complex Queries

```ruby
# Complex relationships
let!(:discussion_thread) { create(:discussion_thread,
  users_count: 5,
  posts_per_user: 3,
  comments_per_post: 4
) }
```

### Level 7-8: Advanced Scenarios

```ruby
# Real-world complex data
let!(:blog_ecosystem) { create(:blog_ecosystem) }
let!(:cross_user_interactions) do
  users = create_list(:user, 4)
  posts = users.flat_map { |u| create_list(:post, 3, user: u) }

  # Create cross-user comments
  posts.each do |post|
    commenting_users = users - [post.user]
    create_list(:comment, 2, post: post, user: commenting_users.sample)
  end
end
```

## Best Practices

### 1. Use Meaningful Names

```ruby
# Good
let!(:active_users) { create_list(:user, 5, :active) }
let!(:popular_posts) { create_list(:post, 3, :popular) }

# Bad
let!(:users) { create_list(:user, 5) }
let!(:posts) { create_list(:post, 3) }
```

### 2. Keep Factories Simple

```ruby
# Good - simple, focused factory
factory :user do
  name { Faker::Name.name }
  email { Faker::Internet.email }
end

# Bad - too many responsibilities
factory :user do
  name { Faker::Name.name }
  email { Faker::Internet.email }
  after(:create) do |user|
    create_list(:post, 5, user: user)
    create_list(:comment, 10, user: user)
    # ... too much
  end
end
```

### 3. Use Traits for Variations

```ruby
factory :post do
  title { Faker::Lorem.sentence }
  content { Faker::Lorem.paragraph }

  trait :with_comments do
    after(:create) { |post| create_list(:comment, 3, post: post) }
  end

  trait :popular do
    with_comments
    after(:create) { |post| create_list(:tag, 2, posts: [post]) }
  end
end
```

### 4. Optimize for Test Speed

```ruby
# Use build_stubbed when you don't need database persistence
users = build_stubbed_list(:user, 100)

# Use create only when you need database features
users = create_list(:user, 5) # for testing queries
```

## Debugging Factories

### Check Factory Validity

```ruby
# In rails console
FactoryBot.create(:user)
FactoryBot.build(:post)
FactoryBot.build_stubbed(:comment)
```

### Lint Factories

```ruby
# In spec file
RSpec.describe "Factory Bot" do
  it "has valid factories" do
    FactoryBot.lint
  end
end
```

This guide should help you understand how to effectively use FactoryBot with your Active Record challenges!
