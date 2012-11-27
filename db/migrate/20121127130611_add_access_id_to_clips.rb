class AddAccessIdToClips < ActiveRecord::Migration
  def change
    add_column :clips, :access_id, :string
  end
end
