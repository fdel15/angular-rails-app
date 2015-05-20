class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.references :post
      t.references :user
      t.index [:post_id, :user_id], unique: true
    end
  end
end
