class Comment < ActiveRecord::Base
  has_many :votes
  belongs_to :post
  belongs_to :user

  def as_json(options = {})
    super(options.merge(include: [:user, :votes]))
  end
end