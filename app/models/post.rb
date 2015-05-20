class Post < ActiveRecord::Base
  has_many :comments
  has_many :votes
  belongs_to :user

  def as_json(options= {})
    super(options.merge(include: [:user, :votes, comments: { include: :user}]))
  end
end