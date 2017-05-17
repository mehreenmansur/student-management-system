class AddFieldsToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :name, :string
    add_column :users, :person_id, :string
    add_column :users, :image, :string
  end
end
