require 'rails_helper'

RSpec.describe "Advanced FactoryBot Scenarios", type: :model do
  describe "Factory Bot Usage Examples" do
    it "creates users with dynamic data" do
      user = create(:user)
      expect(user.name).to be_present
      expect(user.email).to be_present
      expect(user.email).to include("@")
    end

    it "creates user with posts using transient attributes" do
      user = create(:user_with_posts, posts_count: 5)
      expect(user.posts.count).to eq(5)
    end

    it "creates post with comments and tags" do
      post = create(:post_with_comments_and_tags, comments_count: 3, tags_count: 2)
      expect(post.comments.count).to eq(3)
      expect(post.tags.count).to eq(2)
    end

    it "creates specific named factories" do
      john = create(:john_doe)
      ruby_tag = create(:ruby_tag)
      ruby_post = create(:ruby_post, user: john)

      expect(john.name).to eq("John Doe")
      expect(ruby_tag.name).to eq("Ruby")
      expect(ruby_post.title).to eq("Getting Started with Ruby")
    end

    it "creates batch data for performance testing" do
      users = create_list(:user, 10)
      posts = create_list(:post, 20)
      comments = create_list(:comment, 50)

      expect(users.count).to eq(10)
      expect(posts.count).to eq(20)
      expect(comments.count).to eq(50)
    end

    it "creates complex scenarios with traits" do
      # Create a user with 5 posts, each having 2 comments
      user = create(:user)
      posts = create_list(:post_with_comments, 5, user: user, comments_count: 2)

      expect(user.posts.count).to eq(5)
      expect(Comment.where(post: posts).count).to eq(10)
    end
  end

  describe "Factory Bot with Database Performance" do
    it "creates test data efficiently" do
      # Create 100 users with posts and comments efficiently
      users = create_list(:user, 3)

      posts = users.flat_map do |user|
        create_list(:post, 5, user: user)
      end

      comments = posts.flat_map do |post|
        create_list(:comment, 2, post: post, user: users.sample)
      end

      expect(User.count).to eq(3)
      expect(Post.count).to eq(15)
      expect(Comment.count).to eq(30)
    end

    it "uses build_stubbed for faster tests" do
      # build_stubbed creates objects in memory without database calls
      users = build_stubbed_list(:user, 100)

      expect(users.count).to eq(100)
      expect(User.count).to eq(0) # No database records created
    end
  end

  describe "Factory Bot with Complex Associations" do
    it "creates content with cross-references" do
      # Create users who comment on each other's posts
      user1 = create(:user)
      user2 = create(:user)

      post1 = create(:post, user: user1)
      post2 = create(:post, user: user2)

      # User1 comments on User2's post
      comment1 = create(:comment, post: post2, user: user1)
      # User2 comments on User1's post
      comment2 = create(:comment, post: post1, user: user2)

      expect(post1.comments.first.user).to eq(user2)
      expect(post2.comments.first.user).to eq(user1)
    end

    it "creates tagged content with multiple relationships" do
      # Create posts that share tags
      tag1 = create(:ruby_tag)
      tag2 = create(:rails_tag)

      post1 = create(:post)
      post2 = create(:post)
      post3 = create(:post)

      # Posts 1 and 2 share Ruby tag
      post1.tags << tag1
      post2.tags << tag1

      # Posts 2 and 3 share Rails tag
      post2.tags << tag2
      post3.tags << tag2

      expect(tag1.posts.count).to eq(2)
      expect(tag2.posts.count).to eq(2)
      expect(post2.tags.count).to eq(2)
    end
  end
end
