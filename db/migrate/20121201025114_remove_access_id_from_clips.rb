class RemoveAccessIdFromClips < ActiveRecord::Migration
  def up
    remove_column :clips, :access_id
  end

  def down
    add_column :clips, :access_id, :string
  end
end
