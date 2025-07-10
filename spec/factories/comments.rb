FactoryBot.define do
  factory :comment do
    content { Faker::Lorem.sentence(word_count: 4) }
    association :post
    association :user

    # Named factories for specific test comments
    factory :great_tutorial_comment do
      content { "Great tutorial!" }
    end

    factory :helpful_comment do
      content { "Very helpful" }
    end

    factory :thanks_comment do
      content { "Thanks for sharing" }
    end

    factory :excellent_comment do
      content { "Excellent guide" }
    end

    factory :well_written_comment do
      content { "Well written" }
    end

    # Factory for comment with specific post and user
    factory :comment_with_associations do
      transient do
        post_user { nil }
        comment_user { nil }
      end

      after(:build) do |comment, evaluator|
        if evaluator.post_user
          comment.post = create(:post, user: evaluator.post_user)
        end
        if evaluator.comment_user
          comment.user = evaluator.comment_user
        end
      end
    end
  end
end
