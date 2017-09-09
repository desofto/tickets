class AddStatusToRequests < ActiveRecord::Migration[5.1]
  def change
    add_column :requests, :status, :integer, null: false, default: 0, index: true
    add_column :requests, :answered, :datetime
  end
end
