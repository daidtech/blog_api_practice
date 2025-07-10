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
