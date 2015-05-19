class AddUserReferencesToPostsAndComments < ActiveRecord::Migration
  def change
    add_reference :posts, :user
    add_reference :comments, :user
  end
end
