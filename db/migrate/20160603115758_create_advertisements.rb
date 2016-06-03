class CreateAdvertisements < ActiveRecord::Migration[5.0]
  def change
    create_table :advertisements do |t|
      t.string :title
      t.text :content
      t.string :state
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
