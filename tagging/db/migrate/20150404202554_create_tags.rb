class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :text
      t.references :entity, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
