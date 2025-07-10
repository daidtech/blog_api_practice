# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

# Clear existing data to avoid duplicates
puts "Clearing existing data..."
PostTag.destroy_all
Comment.destroy_all
Post.destroy_all
Tag.destroy_all
User.destroy_all

puts "Creating users..."
# Create Users
users = [
  { name: "Alice Johnson", email: "alice@example.com" },
  { name: "Bob Smith", email: "bob@example.com" },
  { name: "Charlie Brown", email: "charlie@example.com" },
  { name: "Diana Wilson", email: "diana@example.com" },
  { name: "Emma Davis", email: "emma@example.com" },
  { name: "Frank Miller", email: "frank@example.com" },
  { name: "Grace Lee", email: "grace@example.com" },
  { name: "Henry Taylor", email: "henry@example.com" }
]

created_users = users.map do |user_data|
  User.create!(user_data)
end

puts "Created #{created_users.length} users"

puts "Creating tags..."
# Create Tags
tag_names = [
  "Ruby", "Rails", "JavaScript", "Python", "React", "Vue.js", "Node.js",
  "API", "Frontend", "Backend", "Database", "PostgreSQL", "MySQL",
  "DevOps", "Docker", "AWS", "Tutorial", "Best Practices", "Performance",
  "Security", "Testing", "Deployment", "Mobile", "Web Development"
]

created_tags = tag_names.map do |tag_name|
  Tag.create!(name: tag_name)
end

puts "Created #{created_tags.length} tags"

puts "Creating posts..."
# Create Posts with realistic content
posts_data = [
  {
    title: "Getting Started with Ruby on Rails",
    content: "Ruby on Rails is a powerful web application framework that makes it easy to build robust applications quickly. In this post, we'll explore the basics of Rails and why it's such a popular choice for web development. Rails follows the convention over configuration principle, which means you can get started quickly without having to make many decisions about how to structure your application.",
    user: created_users[0]
  },
  {
    title: "Building RESTful APIs with Rails",
    content: "RESTful APIs are the backbone of modern web applications. In this comprehensive guide, we'll learn how to build scalable and maintainable APIs using Ruby on Rails. We'll cover everything from basic routing to advanced serialization techniques, authentication, and error handling.",
    user: created_users[1]
  },
  {
    title: "Database Optimization in Rails",
    content: "Database performance is crucial for any web application. In this post, we'll explore various techniques to optimize your Rails application's database queries. We'll cover N+1 queries, eager loading, indexing strategies, and how to use Rails' built-in tools to identify performance bottlenecks.",
    user: created_users[2]
  },
  {
    title: "Frontend Development with React and Rails",
    content: "Combining React with Rails creates a powerful full-stack development experience. This tutorial will guide you through setting up a Rails API backend with a React frontend, handling authentication, and managing state between the two frameworks.",
    user: created_users[0]
  },
  {
    title: "Testing Best Practices in Rails",
    content: "Testing is an essential part of software development. In this article, we'll explore the testing ecosystem in Rails, including unit tests, integration tests, and system tests. We'll also discuss TDD (Test-Driven Development) and how to write maintainable test suites.",
    user: created_users[3]
  },
  {
    title: "Deploying Rails Applications to Production",
    content: "Taking your Rails application from development to production involves many considerations. We'll cover deployment strategies, environment configuration, database migrations, asset compilation, and monitoring. Whether you're using Heroku, AWS, or your own servers, this guide has you covered.",
    user: created_users[4]
  },
  {
    title: "Understanding Active Record Associations",
    content: "Active Record associations are one of the most powerful features of Rails. In this detailed post, we'll explore has_many, belongs_to, has_one, and many-to-many relationships. We'll also cover advanced topics like polymorphic associations and through associations.",
    user: created_users[1]
  },
  {
    title: "Security Best Practices for Rails Applications",
    content: "Security should be a top priority in any web application. Rails provides many built-in security features, but there are additional steps you should take to secure your application. We'll discuss authentication, authorization, SQL injection prevention, XSS protection, and more.",
    user: created_users[5]
  },
  {
    title: "Performance Monitoring and Optimization",
    content: "Monitoring your Rails application's performance is crucial for maintaining a good user experience. In this post, we'll explore various tools and techniques for monitoring performance, identifying bottlenecks, and optimizing your application for better speed and efficiency.",
    user: created_users[2]
  },
  {
    title: "Building Real-time Features with Action Cable",
    content: "Action Cable brings real-time functionality to Rails applications through WebSockets. In this tutorial, we'll build a real-time chat application, exploring how to set up channels, handle connections, and broadcast updates to connected clients.",
    user: created_users[6]
  },
  {
    title: "Microservices Architecture with Rails",
    content: "As applications grow, you might consider breaking them into microservices. This post explores how to architect Rails applications as microservices, including service communication, data consistency, and deployment strategies.",
    user: created_users[3]
  },
  {
    title: "Advanced Rails Console Tips and Tricks",
    content: "The Rails console is a powerful tool for debugging and exploring your application. In this post, we'll share advanced tips and tricks for using the console more effectively, including custom helpers, debugging techniques, and productivity shortcuts.",
    user: created_users[7]
  }
]

created_posts = posts_data.map do |post_data|
  Post.create!(post_data)
end

puts "Created #{created_posts.length} posts"

puts "Creating post-tag associations..."
# Create Post-Tag associations
post_tag_associations = [
  { post: created_posts[0], tags: ["Ruby", "Rails", "Tutorial"] },
  { post: created_posts[1], tags: ["Rails", "API", "Backend"] },
  { post: created_posts[2], tags: ["Rails", "Database", "Performance", "PostgreSQL"] },
  { post: created_posts[3], tags: ["React", "Rails", "Frontend", "JavaScript"] },
  { post: created_posts[4], tags: ["Rails", "Testing", "Best Practices"] },
  { post: created_posts[5], tags: ["Rails", "Deployment", "DevOps", "AWS"] },
  { post: created_posts[6], tags: ["Rails", "Database", "Tutorial"] },
  { post: created_posts[7], tags: ["Rails", "Security", "Best Practices"] },
  { post: created_posts[8], tags: ["Rails", "Performance", "Monitoring"] },
  { post: created_posts[9], tags: ["Rails", "WebSocket", "Real-time"] },
  { post: created_posts[10], tags: ["Rails", "Microservices", "Architecture"] },
  { post: created_posts[11], tags: ["Rails", "Console", "Debugging"] }
]

post_tag_count = 0
post_tag_associations.each do |association|
  post = association[:post]
  tag_names = association[:tags]

  tag_names.each do |tag_name|
    tag = created_tags.find { |t| t.name == tag_name }
    if tag
      PostTag.create!(post: post, tag: tag)
      post_tag_count += 1
    end
  end
end

puts "Created #{post_tag_count} post-tag associations"

puts "Creating comments..."
# Create Comments
comments_data = [
  { content: "Great introduction to Rails! This really helped me understand the basics.", post: created_posts[0], user: created_users[1] },
  { content: "Thanks for sharing this. The convention over configuration principle is one of the things I love most about Rails.", post: created_posts[0], user: created_users[2] },
  { content: "Excellent guide on RESTful APIs. The examples are very clear and easy to follow.", post: created_posts[1], user: created_users[0] },
  { content: "I've been struggling with API design and this post really clarified things for me.", post: created_posts[1], user: created_users[3] },
  { content: "The database optimization tips are gold! My app is running much faster now.", post: created_posts[2], user: created_users[4] },
  { content: "N+1 queries were killing my app's performance. This post saved me!", post: created_posts[2], user: created_users[1] },
  { content: "React + Rails is such a powerful combination. Thanks for the tutorial!", post: created_posts[3], user: created_users[5] },
  { content: "I was looking for exactly this kind of setup. The authentication part was particularly helpful.", post: created_posts[3], user: created_users[2] },
  { content: "Testing has always been intimidating to me, but this post makes it seem approachable.", post: created_posts[4], user: created_users[6] },
  { content: "TDD changed my development workflow completely. Great explanation of the concepts.", post: created_posts[4], user: created_users[0] },
  { content: "Deployment can be tricky, but this guide covers all the important aspects.", post: created_posts[5], user: created_users[7] },
  { content: "The environment configuration section was exactly what I needed. Thanks!", post: created_posts[5], user: created_users[1] },
  { content: "Active Record associations are so powerful once you understand them properly.", post: created_posts[6], user: created_users[3] },
  { content: "The polymorphic associations example really cleared up my confusion.", post: created_posts[6], user: created_users[4] },
  { content: "Security is so important and often overlooked. Great comprehensive guide!", post: created_posts[7], user: created_users[2] },
  { content: "The XSS protection tips are particularly valuable. Thanks for sharing!", post: created_posts[7], user: created_users[5] },
  { content: "Performance monitoring is crucial for production apps. Great tool recommendations!", post: created_posts[8], user: created_users[6] },
  { content: "I implemented some of these optimizations and saw immediate improvements.", post: created_posts[8], user: created_users[0] },
  { content: "Action Cable is amazing for real-time features. The chat example is perfect!", post: created_posts[9], user: created_users[7] },
  { content: "WebSockets were confusing to me before, but this tutorial makes it clear.", post: created_posts[9], user: created_users[1] },
  { content: "Microservices architecture is complex, but this post breaks it down well.", post: created_posts[10], user: created_users[4] },
  { content: "The service communication patterns are really useful. Thanks for the insights!", post: created_posts[10], user: created_users[3] },
  { content: "I learn so much from these console tips! My debugging process is much faster now.", post: created_posts[11], user: created_users[5] },
  { content: "The custom helpers section is genius. I'm implementing these right away.", post: created_posts[11], user: created_users[2] }
]

created_comments = comments_data.map do |comment_data|
  Comment.create!(comment_data)
end

puts "Created #{created_comments.length} comments"

puts "Seed data creation completed successfully!"
puts "Summary:"
puts "- Users: #{User.count}"
puts "- Posts: #{Post.count}"
puts "- Comments: #{Comment.count}"
puts "- Tags: #{Tag.count}"
puts "- Post-Tag associations: #{PostTag.count}"
