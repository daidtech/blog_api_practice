require 'rails_helper'

RSpec.describe "ActiveRecord Query Challenges", type: :model do
  # Setup test data
  let!(:user1) { User.create!(name: "John Doe", email: "john@example.com") }
  let!(:user2) { User.create!(name: "Jane Smith", email: "jane@example.com") }
  let!(:user3) { User.create!(name: "Bob Wilson", email: "bob@example.com") }

  let!(:tag1) { Tag.create!(name: "Ruby") }
  let!(:tag2) { Tag.create!(name: "Rails") }
  let!(:tag3) { Tag.create!(name: "JavaScript") }
  let!(:tag4) { Tag.create!(name: "React") }

  let!(:post1) { Post.create!(title: "Getting Started with Ruby", content: "Ruby basics tutorial", user: user1) }
  let!(:post2) { Post.create!(title: "Advanced Rails Techniques", content: "Advanced Rails concepts", user: user1) }
  let!(:post3) { Post.create!(title: "JavaScript for Beginners", content: "JS fundamentals", user: user2) }
  let!(:post4) { Post.create!(title: "React Development", content: "React components guide", user: user2) }
  let!(:post5) { Post.create!(title: "Database Optimization", content: "SQL optimization tips", user: user3) }

  let!(:comment1) { Comment.create!(content: "Great tutorial!", post: post1, user: user2) }
  let!(:comment2) { Comment.create!(content: "Very helpful", post: post1, user: user3) }
  let!(:comment3) { Comment.create!(content: "Thanks for sharing", post: post2, user: user2) }
  let!(:comment4) { Comment.create!(content: "Excellent guide", post: post3, user: user1) }
  let!(:comment5) { Comment.create!(content: "Well written", post: post4, user: user1) }

  # Create post-tag associations
  before do
    post1.tags << [tag1, tag2]
    post2.tags << [tag1, tag2]
    post3.tags << [tag3]
    post4.tags << [tag3, tag4]
  end

  # ================== LEVEL 1: BASIC QUERIES ==================

  describe "Level 1: Basic Queries" do
    it "Challenge 1.1: Find all users" do
      # TODO: Write a query to find all users
      # Expected: All 3 users

      result = nil # Replace with your query

      expect(result.count).to eq(3)
    end

    it "Challenge 1.2: Find user by email" do
      # TODO: Find user with email 'john@example.com'

      result = nil # Replace with your query

      expect(result.email).to eq('john@example.com')
    end

    it "Challenge 1.3: Find posts ordered by title" do
      # TODO: Get all posts ordered by title alphabetically

      result = nil # Replace with your query

      expect(result.first.title).to eq("Advanced Rails Techniques")
      expect(result.last.title).to eq("React Development")
    end

    it "Challenge 1.4: Count total posts" do
      # TODO: Count the total number of posts

      result = nil # Replace with your query

      expect(result).to eq(5)
    end
  end

  # ================== LEVEL 2: FILTERING & CONDITIONS ==================

  describe "Level 2: Filtering & Conditions" do
    it "Challenge 2.1: Find posts by specific user" do
      # TODO: Find all posts by user1

      result = nil # Replace with your query

      expect(result.count).to eq(2)
      expect(result.all? { |post| post.user == user1 }).to be true
    end

    it "Challenge 2.2: Find posts with title containing 'Rails'" do
      # TODO: Find posts where title contains 'Rails'

      result = nil # Replace with your query

      expect(result.count).to eq(1)
      expect(result.first.title).to include("Rails")
    end

    it "Challenge 2.3: Find users whose name starts with 'J'" do
      # TODO: Find users whose name starts with 'J'

      result = nil # Replace with your query

      expect(result.count).to eq(2)
      expect(result.map(&:name)).to contain_exactly("John Doe", "Jane Smith")
    end

    it "Challenge 2.4: Find posts created in the last day" do
      # TODO: Find posts created in the last 24 hours

      result = nil # Replace with your query

      expect(result.count).to eq(5) # All posts were created today
    end
  end

  # ================== LEVEL 3: ASSOCIATIONS & JOINS ==================

  describe "Level 3: Associations & Joins" do
    it "Challenge 3.1: Find all posts with their users" do
      # TODO: Find all posts and eager load their users to avoid N+1 queries

      result = nil # Replace with your query

      expect(result.count).to eq(5)
      # Check that users are preloaded
      expect { result.each { |post| post.user.name } }.not_to exceed_query_limit(1)
    end

    it "Challenge 3.2: Find posts that have comments" do
      # TODO: Find posts that have at least one comment

      result = nil # Replace with your query

      expect(result.count).to eq(4)
      expect(result.map(&:title)).not_to include("Database Optimization")
    end

    it "Challenge 3.3: Find users who have written posts" do
      # TODO: Find users who have at least one post

      result = nil # Replace with your query

      expect(result.count).to eq(3)
    end

    it "Challenge 3.4: Find comments with post and user information" do
      # TODO: Find all comments and include post and user information

      result = nil # Replace with your query

      expect(result.count).to eq(5)
      # Check that associations are preloaded
      expect { result.each { |comment| comment.post.title + comment.user.name } }.not_to exceed_query_limit(1)
    end
  end

  # ================== LEVEL 4: AGGREGATIONS & GROUPING ==================

  describe "Level 4: Aggregations & Grouping" do
    it "Challenge 4.1: Count posts per user" do
      # TODO: Get count of posts for each user
      # Return format: { user_id => post_count }

      result = nil # Replace with your query

      expect(result[user1.id]).to eq(2)
      expect(result[user2.id]).to eq(2)
      expect(result[user3.id]).to eq(1)
    end

    it "Challenge 4.2: Find users with their post count" do
      # TODO: Get users along with their post counts
      # Use select to add post_count as an attribute

      result = nil # Replace with your query

      john = result.find { |user| user.name == "John Doe" }
      expect(john.post_count).to eq(2)
    end

    it "Challenge 4.3: Count comments per post" do
      # TODO: Get comment count for each post

      result = nil # Replace with your query

      post1_count = result.find { |post| post.id == post1.id }.comment_count
      expect(post1_count).to eq(2)
    end

    it "Challenge 4.4: Find average number of comments per post" do
      # TODO: Calculate the average number of comments per post

      result = nil # Replace with your query

      expect(result).to eq(1.0) # 5 comments / 5 posts = 1.0
    end
  end

  # ================== LEVEL 5: COMPLEX QUERIES ==================

  describe "Level 5: Complex Queries" do
    it "Challenge 5.1: Find users who have both posts and comments" do
      # TODO: Find users who have written at least one post AND made at least one comment

      result = nil # Replace with your query

      expect(result.count).to eq(2)
      expect(result.map(&:name)).to contain_exactly("John Doe", "Jane Smith")
    end

    it "Challenge 5.2: Find posts with more than 1 comment" do
      # TODO: Find posts that have more than 1 comment

      result = nil # Replace with your query

      expect(result.count).to eq(1)
      expect(result.first.title).to eq("Getting Started with Ruby")
    end

    it "Challenge 5.3: Find users ordered by number of posts (descending)" do
      # TODO: Find users ordered by their post count in descending order

      result = nil # Replace with your query

      expect(result.first.post_count).to eq(2)
      expect(result.last.post_count).to eq(1)
    end

    it "Challenge 5.4: Find posts with their tag names" do
      # TODO: Find posts and include their tag names as a comma-separated string

      result = nil # Replace with your query

      post_with_tags = result.find { |post| post.id == post1.id }
      expect(post_with_tags.tag_names).to include("Ruby")
      expect(post_with_tags.tag_names).to include("Rails")
    end
  end

  # ================== LEVEL 6: ADVANCED QUERIES ==================

  describe "Level 6: Advanced Queries" do
    it "Challenge 6.1: Find posts that have tags but no comments" do
      # TODO: Find posts that have at least one tag but no comments

      result = nil # Replace with your query

      expect(result.count).to eq(1)
      expect(result.first.title).to eq("Database Optimization")
    end

    it "Challenge 6.2: Find users with most commented posts" do
      # TODO: Find users whose posts have received the most comments

      result = nil # Replace with your query

      expect(result.first.name).to eq("John Doe")
      expect(result.first.total_comments).to eq(3)
    end

    it "Challenge 6.3: Find tags that are used in multiple posts" do
      # TODO: Find tags that appear in more than one post

      result = nil # Replace with your query

      expect(result.count).to eq(2)
      expect(result.map(&:name)).to contain_exactly("Ruby", "Rails")
    end

    it "Challenge 6.4: Find posts with specific tag combinations" do
      # TODO: Find posts that have both 'Ruby' AND 'Rails' tags

      result = nil # Replace with your query

      expect(result.count).to eq(2)
      expect(result.map(&:title)).to contain_exactly("Getting Started with Ruby", "Advanced Rails Techniques")
    end
  end

  # ================== LEVEL 7: EXPERT QUERIES ==================

  describe "Level 7: Expert Queries" do
    it "Challenge 7.1: Find users who commented on posts they didn't write" do
      # TODO: Find users who have commented on posts written by other users

      result = nil # Replace with your query

      expect(result.count).to eq(3)
    end

    it "Challenge 7.2: Find the most active user (posts + comments)" do
      # TODO: Find the user with the highest combined count of posts and comments

      result = nil # Replace with your query

      expect(result.name).to eq("John Doe")
      expect(result.activity_score).to eq(4) # 2 posts + 2 comments
    end

    it "Challenge 7.3: Find posts with comment-to-tag ratio" do
      # TODO: Find posts with their comment count to tag count ratio
      # Posts with no tags should have a ratio of 0

      result = nil # Replace with your query

      post_with_ratio = result.find { |post| post.id == post1.id }
      expect(post_with_ratio.comment_tag_ratio).to eq(1.0) # 2 comments / 2 tags = 1.0
    end

    it "Challenge 7.4: Find users with their engagement metrics" do
      # TODO: Find users with their post count, comment count, and engagement score
      # Engagement score = (posts * 2) + comments

      result = nil # Replace with your query

      john = result.find { |user| user.name == "John Doe" }
      expect(john.engagement_score).to eq(6) # (2 * 2) + 2 = 6
    end
  end

  # ================== LEVEL 8: MASTER QUERIES ==================

  describe "Level 8: Master Level Queries" do
    it "Challenge 8.1: Find trending posts (posts with recent comments)" do
      # TODO: Find posts that received comments in the last 24 hours, ordered by comment count

      result = nil # Replace with your query

      expect(result.first.title).to eq("Getting Started with Ruby")
      expect(result.first.recent_comment_count).to eq(2)
    end

    it "Challenge 8.2: Complex user statistics" do
      # TODO: Get comprehensive user statistics including:
      # - Total posts
      # - Total comments made
      # - Total comments received on their posts
      # - Average comments per post

      result = nil # Replace with your query

      john_stats = result.find { |user| user.name == "John Doe" }
      expect(john_stats.posts_count).to eq(2)
      expect(john_stats.comments_made).to eq(2)
      expect(john_stats.comments_received).to eq(3)
      expect(john_stats.avg_comments_per_post).to eq(1.5)
    end

    it "Challenge 8.3: Find content creators vs commenters" do
      # TODO: Categorize users as 'creator' (more posts than comments) or 'commenter' (more comments than posts)

      result = nil # Replace with your query

      expect(result['creator'].count).to eq(1)
      expect(result['commenter'].count).to eq(2)
    end

    it "Challenge 8.4: Advanced search with multiple conditions" do
      # TODO: Find posts that:
      # - Have a title containing 'Ruby' OR 'Rails'
      # - Have at least 1 comment
      # - Are tagged with 'Ruby'
      # - Were created by users whose name starts with 'J'

      result = nil # Replace with your query

      expect(result.count).to eq(2)
      expect(result.all? { |post| post.user.name.start_with?('J') }).to be true
    end
  end
end
