class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.references :post
      t.references :comment
      t.references :user
      t.string :vote_type, default: "up"
      t.index [:post_id, :user_id], unique: true
    end
  end
end
