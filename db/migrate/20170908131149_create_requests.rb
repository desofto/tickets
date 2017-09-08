class CreateRequests < ActiveRecord::Migration[5.1]
  def change
    create_table :requests do |t|
      t.references :client, references: 'users', index: true
      t.references :agent, references: 'users', index: true
      t.string :subject, null: false
      t.datetime :opened, null: false, index: true
      t.datetime :closed, index: true
      t.datetime :archived, index: true

      t.timestamps null: false
    end
  end
end
