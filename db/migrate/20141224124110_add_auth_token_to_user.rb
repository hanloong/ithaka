class AddAuthTokenToUser < ActiveRecord::Migration
  def up
    add_column :users, :authentication_token, :string

    # add auth token
    User.all.each {|u| u.save}
  end

  def down
    remove_column :users, :authentication_token
  end
end
