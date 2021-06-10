class Post < ActiveRecord::Base
  belongs_to :user

  # TODO: Copy-paste your code from previous exercise

  # we create a scope that allows us to create easy-to-use methods elswehre in our applications
  # For quick activerecord queries on our instances
  # The below scope is used: Post.all.by_votes_descending
  scope :by_votes_descending, -> { order(votes: :desc) }

  # Other scopes could be like this
  # Display only posts with less than 50 votes
  scope :votes_less_than_50, -> { where("votes < ?", 50) }
end
