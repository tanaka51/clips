class AddUidToGroups < ActiveRecord::Migration
  def change
    add_column :groups, :uid, :string
  end
end
