class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :type, null: false, limit: 10
      t.string :email, null: false, limit: 100
      t.string :auth_token, limit: 100

      t.timestamps null: false
    end
  end
end
