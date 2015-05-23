class AddNotNullConstraintsToPosts < ActiveRecord::Migration
  def change
    change_table :posts do |t|
      t.change(:title, :string, null: false)
      t.change(:link, :string, null: false)
      t.change(:user_id, :integer, null: false)
    end
  end
end
