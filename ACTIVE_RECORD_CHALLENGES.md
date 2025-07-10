# Active Record Query Challenges 🚀

Welcome to your Active Record query practice! This set of challenges will help you review and master Rails Active Record queries, from basic to expert level.

## Setup Instructions

1. **Install dependencies:**
   ```bash
   bundle install
   ```

2. **Setup the database:**
   ```bash
   rails db:create
   rails db:migrate
   rails db:seed
   ```

3. **Run the challenges:**
   ```bash
   rspec spec/active_record_challenges_spec.rb
   ```

## Challenge Structure

### 📚 Database Schema
Your blog application has these models:
- **User**: `name`, `email`
- **Post**: `title`, `content`, `user_id`
- **Comment**: `content`, `post_id`, `user_id`
- **Tag**: `name`
- **PostTag**: `post_id`, `tag_id` (join table)

### 🎯 Challenge Levels

#### Level 1: Basic Queries (Beginner)
- Finding records
- Basic filtering
- Counting
- Ordering

#### Level 2: Filtering & Conditions (Beginner+)
- WHERE clauses
- Pattern matching
- Date/time filtering
- Multiple conditions

#### Level 3: Associations & Joins (Intermediate)
- Eager loading
- N+1 query prevention
- Basic joins
- Association queries

#### Level 4: Aggregations & Grouping (Intermediate+)
- COUNT, SUM, AVG
- GROUP BY
- HAVING clauses
- Statistical queries

#### Level 5: Complex Queries (Advanced)
- Multiple joins
- Subqueries
- Complex conditions
- Performance optimization

#### Level 6: Advanced Queries (Advanced+)
- Complex associations
- Advanced aggregations
- Multiple table joins
- Conditional logic

#### Level 7: Expert Queries (Expert)
- Complex business logic
- Performance-critical queries
- Advanced SQL techniques
- Data analysis queries

#### Level 8: Master Queries (Master)
- Real-world complex scenarios
- Multi-table analytics
- Advanced reporting
- Production-level queries

## How to Use

1. **Read each challenge description carefully**
2. **Replace `nil` with your Active Record query**
3. **Run the specific test to check your solution:**
   ```bash
   rspec spec/active_record_challenges_spec.rb:line_number
   ```
4. **Check the solutions file if you get stuck** (but try first!)
5. **Move to the next challenge once you pass**

## Tips for Success

### 🔍 Common Active Record Methods
- `find`, `find_by`, `where`, `joins`, `includes`
- `select`, `group`, `having`, `order`, `limit`
- `count`, `sum`, `average`, `maximum`, `minimum`
- `distinct`, `exists?`, `left_joins`

### 💡 Performance Tips
- Use `includes` for eager loading to avoid N+1 queries
- Use `joins` when you only need to filter, not load associated data
- Use `select` to limit columns when dealing with large datasets
- Use `find_each` for batch processing large datasets

### 🚨 Common Gotchas
- Remember to use `distinct` when joining tables to avoid duplicates
- Use `left_joins` when you want to include records without associations
- Use proper SQL escaping with `?` placeholders for security
- Use `ILIKE` for case-insensitive searches in PostgreSQL

## Example Solutions

### Basic Query Example:
```ruby
# Find all users
User.all

# Find user by email
User.find_by(email: 'john@example.com')
```

### Intermediate Query Example:
```ruby
# Find posts with their users (avoiding N+1)
Post.includes(:user)

# Count posts per user
Post.group(:user_id).count
```

### Advanced Query Example:
```ruby
# Find users with their post count
User.left_joins(:posts)
    .group(:id)
    .select("users.*, COUNT(posts.id) as post_count")
```

## Testing Your Solutions

Each challenge has specific expectations. Make sure your query:
1. **Returns the correct data**
2. **Has the expected count**
3. **Includes the right associations**
4. **Performs efficiently** (for advanced challenges)

## Need Help?

1. **Check the Rails documentation**: https://guides.rubyonrails.org/active_record_querying.html
2. **Look at the solutions file** (after attempting!)
3. **Use Rails console** to test queries: `rails console`
4. **Check the schema** to understand table relationships

## Progress Tracking

- [ ] Level 1: Basic Queries (4 challenges)
- [ ] Level 2: Filtering & Conditions (4 challenges)
- [ ] Level 3: Associations & Joins (4 challenges)
- [ ] Level 4: Aggregations & Grouping (4 challenges)
- [ ] Level 5: Complex Queries (4 challenges)
- [ ] Level 6: Advanced Queries (4 challenges)
- [ ] Level 7: Expert Queries (4 challenges)
- [ ] Level 8: Master Queries (4 challenges)

Good luck with your Active Record journey! 🎉

Remember: The goal is not just to pass the tests, but to understand the underlying concepts and write efficient, maintainable queries.
