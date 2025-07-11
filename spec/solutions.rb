# SOLUTIONS FOR ACTIVE RECORD CHALLENGES
# Use this file to check your answers after attempting each challenge

# ================== LEVEL 1: BASIC QUERIES ==================

# Challenge 1.1: Find all users
User.all

# Challenge 1.2: Find user by email
User.find_by(email: 'john@example.com')

# Challenge 1.3: Find posts ordered by title
Post.order(:title)

# Challenge 1.4: Count total posts
Post.count

# ================== LEVEL 2: FILTERING & CONDITIONS ==================

# Challenge 2.1: Find posts by specific user
user1.posts
# or
Post.where(user: user1)

# Challenge 2.2: Find posts with title containing 'Rails'
Post.where("title ILIKE ?", "%Rails%")

# Challenge 2.3: Find users whose name starts with 'J'
User.where("name ILIKE ?", "J%")

# Challenge 2.4: Find posts created in the last day
Post.where(created_at: 1.day.ago..Time.current)

# ================== LEVEL 3: ASSOCIATIONS & JOINS ==================

# Challenge 3.1: Find all posts with their users
Post.includes(:user)

# Challenge 3.2: Find posts that have comments
Post.joins(:comments).distinct

# Challenge 3.3: Find users who have written posts
User.joins(:posts).distinct

# Challenge 3.4: Find comments with post and user information
Comment.includes(:post, :user)

# ================== LEVEL 4: AGGREGATIONS & GROUPING ==================

# Challenge 4.1: Count posts per user
Post.group(:user_id).count

# Challenge 4.2: Find users with their post count
User.left_joins(:posts).group(:id).select("users.*, COUNT(posts.id) as post_count")

# Challenge 4.3: Count comments per post
Post.left_joins(:comments).group(:id).select("posts.*, COUNT(comments.id) as comment_count")

# Challenge 4.4: Find average number of comments per post
Comment.count.to_f / Post.count

# ================== LEVEL 5: COMPLEX QUERIES ==================

# Challenge 5.1: Find users who have both posts and comments
User.joins(:posts).joins(:comments).distinct

# Challenge 5.2: Find posts with more than 1 comment
Post.joins(:comments).group("posts.id").having("COUNT(comments.id) > 1").select("posts.*").to_a

# Challenge 5.3: Find users ordered by number of posts (descending)
User.left_joins(:posts).group(:id).select("users.*, COUNT(posts.id) as post_count").order("post_count DESC")

# Challenge 5.4: Find posts with their tag names
Post.left_joins(:tags).group("posts.id").select("posts.*, STRING_AGG(tags.name, ', ') as tag_names")

# ================== LEVEL 6: ADVANCED QUERIES ==================

# Challenge 6.1: Find posts that have tags but no comments
Post.joins(:tags).left_joins(:comments).where(comments: { id: nil }).distinct

# Challenge 6.2: Find users with most commented posts
User.joins(posts: :comments).group("users.id").select("users.*, COUNT(comments.id) as total_comments").order("total_comments DESC")

# Challenge 6.3: Find tags that are used in multiple posts
Tag.joins(:posts).group("tags.id").having("COUNT(posts.id) > 1").select("tags.*").to_a

# Challenge 6.4: Find posts with specific tag combinations
Post.joins(:tags).where(tags: { name: ['Ruby', 'Rails'] }).group("posts.id").having("COUNT(tags.id) = 2").select("posts.*").to_a

# ================== LEVEL 7: EXPERT QUERIES ==================

# Challenge 7.1: Find users who commented on posts they didn't write
User.joins(:comments).joins("JOIN posts ON comments.post_id = posts.id").where("posts.user_id != users.id").distinct

# Challenge 7.2: Find the most active user (posts + comments)
User.left_joins(:posts).left_joins(:comments).group(:id).select("users.*, (COUNT(DISTINCT posts.id) + COUNT(DISTINCT comments.id)) as activity_score").order("activity_score DESC").first

# Challenge 7.3: Find posts with comment-to-tag ratio
Post.left_joins(:comments).left_joins(:tags).group("posts.id").select("posts.*, CASE WHEN COUNT(DISTINCT tags.id) = 0 THEN 0 ELSE COUNT(DISTINCT comments.id)::float / COUNT(DISTINCT tags.id) END as comment_tag_ratio")

# Challenge 7.4: Find users with their engagement metrics
User.left_joins(:posts).left_joins(:comments).group(:id).select("users.*, COUNT(DISTINCT posts.id) as posts_count, COUNT(DISTINCT comments.id) as comments_count, (COUNT(DISTINCT posts.id) * 2 + COUNT(DISTINCT comments.id)) as engagement_score")

# ================== LEVEL 8: MASTER QUERIES ==================

# Challenge 8.1: Find trending posts (posts with recent comments)
Post.joins(:comments).where(comments: { created_at: 1.day.ago..Time.current }).group("posts.id").select("posts.*, COUNT(comments.id) as recent_comment_count").order("recent_comment_count DESC")

# Challenge 8.2: Complex user statistics
# Method 1: Split into multiple queries for clarity
user_stats = User.left_joins(:posts).left_joins(:comments).group(:id).select("users.*, COUNT(DISTINCT posts.id) as posts_count, COUNT(DISTINCT comments.id) as comments_made")
comments_received = Comment.joins(:post).joins("JOIN users ON posts.user_id = users.id").group("users.id").count
result = user_stats.map do |user|
  received_count = comments_received[user.id] || 0
  avg_comments = user.posts_count > 0 ? received_count.to_f / user.posts_count : 0
  user.define_singleton_method(:comments_received) { received_count }
  user.define_singleton_method(:avg_comments_per_post) { avg_comments }
  user
end

# Method 2: Single complex query (alternative approach)
# User.left_joins(:posts).left_joins(:comments).left_joins("LEFT JOIN comments post_comments ON posts.id = post_comments.post_id").group(:id).select("users.*, COUNT(DISTINCT posts.id) as posts_count, COUNT(DISTINCT comments.id) as comments_made, COUNT(DISTINCT post_comments.id) as comments_received, CASE WHEN COUNT(DISTINCT posts.id) = 0 THEN 0 ELSE COUNT(DISTINCT post_comments.id)::float / COUNT(DISTINCT posts.id) END as avg_comments_per_post")

# Challenge 8.3: Find content creators vs commenters
users_with_counts = User.left_joins(:posts).left_joins(:comments).group(:id).select("users.*, COUNT(DISTINCT posts.id) as posts_count, COUNT(DISTINCT comments.id) as comments_count")
{
  'creator' => users_with_counts.select { |user| user.posts_count > user.comments_count },
  'commenter' => users_with_counts.select { |user| user.comments_count > user.posts_count }
}

# Challenge 8.4: Advanced search with multiple conditions
Post.joins(:comments).joins(:tags).joins(:user).where(
  "(posts.title ILIKE ? OR posts.title ILIKE ?) AND tags.name = ? AND users.name ILIKE ?",
  "%Ruby%", "%Rails%", "Ruby", "J%"
).distinct
