class Post < ActiveRecord::Base
  has_many :comments
  has_many :votes
  belongs_to :user

  def as_json(options= {})
    super(options.merge(include: [:user, :votes, comments: { include: [:user, :votes]}], methods: :number_of_votes))
  end

  def number_of_votes
    total_votes = votes.count
    upvotes = votes.select{|vote| vote.type == "up"}.count
    downvotes = total_votes - upvotes
    return upvotes - downvotes
  end
end