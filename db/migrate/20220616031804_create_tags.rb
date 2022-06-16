class CreateTags < ActiveRecord::Migration[7.0]
  def change
    create_table :tags do |t|
      t.string :tag_name
      t.integer :num_occurrences
      t.timestamps
      t.references :ticket, null:false, foreign_key: true
    end
  end
end
