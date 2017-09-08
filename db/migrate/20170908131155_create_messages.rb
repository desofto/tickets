class CreateMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :messages do |t|
      t.references :request, index: true
      t.text :body, null: false

      t.timestamps null: false
    end
  end
end
