class Post < ActiveRecord::Base
  has_many :comments
  has_many :votes
  belongs_to :user

  validates_presence_of :title, :link, :user_id
  validates_uniqueness_of :link


  def as_json(options= {})
    super(options.merge(include: [:user, :votes, comments: { include: [:user, :votes], methods: :number_of_votes}], methods: :number_of_votes))
  end

  def number_of_votes
    total_votes = votes.count
    upvotes = votes.select{|vote| vote.vote_type == "up"}.count
    downvotes = total_votes - upvotes
    return upvotes - downvotes
  end
end