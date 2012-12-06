class CreateGroupsUsers < ActiveRecord::Migration
  def up
    create_table :groups_users do |t|
      t.column :group_id, :integer, :null => false
      t.column :user_id,  :integer, :null => false
    end
  end

  def down
    drop_table :groups_users
  end
end
