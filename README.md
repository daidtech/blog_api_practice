# Blog API Practice - Active Record Query Challenges 🚀

A comprehensive Ruby on Rails application designed for practicing Active Record queries, from basic to expert level. Perfect for preparing for senior Rails developer interviews and reviewing Rails/ActiveRecord concepts.

## 📋 Overview

This project provides a structured learning path through **32 Active Record challenges** across 8 difficulty levels, using a realistic blog application with Users, Posts, Comments, and Tags.

## 🎯 What You'll Learn

- **Active Record Query Optimization** - Write efficient database queries
- **Association Management** - Master complex relationships between models
- **Performance Optimization** - Avoid N+1 queries and optimize database performance
- **Advanced SQL through Rails** - Complex joins, aggregations, and subqueries
- **Factory Bot Patterns** - Modern test data generation techniques
- **RSpec Testing** - Comprehensive test-driven development

## 🗂️ Project Structure

```
├── app/models/           # Rails models with associations
├── db/                   # Database migrations and schema
├── spec/                 # RSpec tests and factories
│   ├── factories/        # FactoryBot factories for test data
│   ├── active_record_challenges_spec.rb  # Main challenge tests
│   └── factory_examples_spec.rb         # Factory usage examples
├── ACTIVE_RECORD_CHALLENGES.md  # Complete challenge guide
├── FACTORY_BOT_GUIDE.md         # FactoryBot documentation
└── README.md            # This file
```

## 🚀 Quick Start

### Prerequisites
- Ruby 3.2.2
- Rails 7.1+
- PostgreSQL

### Setup
```bash
# Clone and navigate to project
cd blog_api_practice

# Install dependencies
bundle install

# Setup database
rails db:create
rails db:migrate
rails db:seed

# Run all challenges
rspec spec/active_record_challenges_spec.rb

# Run specific challenge level
rspec spec/active_record_challenges_spec.rb -e "Level 1"
```

## 📚 Documentation

### 🎯 [Active Record Challenges Guide](ACTIVE_RECORD_CHALLENGES.md)
- **32 Progressive Challenges** from basic to master level
- **Detailed Instructions** for each challenge
- **Expected Outcomes** and testing criteria
- **Performance Tips** and best practices

### 🏭 [FactoryBot Guide](FACTORY_BOT_GUIDE.md)
- **Modern Test Data Generation** with FactoryBot
- **Performance Optimization** techniques
- **Advanced Patterns** for complex scenarios
- **Real-world Examples** and best practices

## 🎲 Challenge Levels

| Level | Difficulty | Topics Covered | Challenges |
|-------|------------|----------------|------------|
| **Level 1** | Beginner | Basic queries, finding, counting | 4 |
| **Level 2** | Beginner+ | Filtering, conditions, pattern matching | 4 |
| **Level 3** | Intermediate | Associations, joins, eager loading | 4 |
| **Level 4** | Intermediate+ | Aggregations, grouping, statistics | 4 |
| **Level 5** | Advanced | Complex queries, multiple joins | 4 |
| **Level 6** | Advanced+ | Advanced associations, complex logic | 4 |
| **Level 7** | Expert | Performance optimization, real-world scenarios | 4 |
| **Level 8** | Master | Production-level queries, analytics | 4 |

## 🧪 Database Schema

```ruby
# Core Models
User: name, email
Post: title, content, user_id
Comment: content, post_id, user_id
Tag: name
PostTag: post_id, tag_id (join table)

# Relationships
User has_many Posts, Comments
Post belongs_to User, has_many Comments, Tags (through PostTags)
Comment belongs_to User, Post
Tag has_many Posts (through PostTags)
```

## 🎯 Example Challenges

### Level 1: Basic Queries
```ruby
# Find all users
result = User.all

# Find user by email
result = User.find_by(email: 'john@example.com')
```

### Level 5: Complex Queries
```ruby
# Find users who have both posts and comments
result = User.joins(:posts).joins(:comments).distinct
```

### Level 8: Master Queries
```ruby
# Complex user statistics with posts, comments, and engagement metrics
result = User.left_joins(:posts).left_joins(:comments)
             .group(:id)
             .select("users.*, COUNT(DISTINCT posts.id) as posts_count,
                      COUNT(DISTINCT comments.id) as comments_count,
                      (COUNT(DISTINCT posts.id) * 2 + COUNT(DISTINCT comments.id)) as engagement_score")
```

## 🏗️ Technical Features

### Modern Rails Patterns
- **Active Record 7.1+** with latest query methods
- **PostgreSQL** for advanced SQL features
- **Factory Bot** for maintainable test data
- **RSpec** for comprehensive testing

### Performance Optimizations
- **Eager Loading** with `includes` and `joins`
- **Bulk Operations** for large datasets
- **Query Optimization** techniques
- **N+1 Query Prevention** strategies

## 🧪 Testing

### Run All Tests
```bash
rspec
```

### Run Specific Challenge Levels
```bash
rspec spec/active_record_challenges_spec.rb -e "Level 1"
rspec spec/active_record_challenges_spec.rb -e "Level 5"
```

### Test Factory Examples
```bash
rspec spec/factory_examples_spec.rb
```

### Check Your Progress
```bash
# Run challenges one by one
rspec spec/active_record_challenges_spec.rb:45  # Specific line
```

## 📈 Learning Path

### For Beginners
1. Start with **Level 1-2** challenges
2. Read the [Active Record Challenges Guide](ACTIVE_RECORD_CHALLENGES.md)
3. Practice basic queries and filtering

### For Intermediate Developers
1. Focus on **Level 3-5** challenges
2. Master associations and aggregations
3. Learn performance optimization techniques

### For Advanced/Senior Developers
1. Tackle **Level 6-8** challenges
2. Study complex query patterns
3. Focus on production-ready optimizations

## 🎯 Interview Preparation

This project is specifically designed for Rails interview preparation:

- **Common Interview Questions** covered in challenges
- **Performance Optimization** focus
- **Real-world Scenarios** similar to production code
- **Progressive Difficulty** to build confidence

## 🤝 Contributing

Feel free to:
- Add new challenges
- Improve existing documentation
- Suggest performance optimizations
- Share your solutions and approaches

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🔗 Related Resources

- [Rails Active Record Querying Guide](https://guides.rubyonrails.org/active_record_querying.html)
- [FactoryBot Documentation](https://github.com/thoughtbot/factory_bot)
- [RSpec Rails Documentation](https://github.com/rspec/rspec-rails)

---

**Happy Learning!** 🎉 Master Active Record queries and ace your Rails interviews!
