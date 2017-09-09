class AddAuthorToMessages < ActiveRecord::Migration[5.1]
  def change
    add_reference :messages, :author, references: 'users', null: false, index: true
  end
end
