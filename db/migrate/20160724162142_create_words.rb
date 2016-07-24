class CreateWords < ActiveRecord::Migration[5.0]
  def change
    create_table :words do |t|
      t.string 'word', null: false
      t.string 'meaning', default: '', null: false
      t.string 'example', default: '', null: false
      t.integer 'language', default: 1, null: false
      t.boolean 'active', default: false, null: false

      t.timestamps null: false
    end
  end
end
