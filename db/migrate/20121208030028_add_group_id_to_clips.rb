class AddGroupIdToClips < ActiveRecord::Migration
  def change
    add_column :clips, :group_id, :integer
  end
end
