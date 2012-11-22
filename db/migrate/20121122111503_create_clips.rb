class CreateClips < ActiveRecord::Migration
  def change
    create_table :clips do |t|
      t.text :code

      t.timestamps
    end
  end
end
