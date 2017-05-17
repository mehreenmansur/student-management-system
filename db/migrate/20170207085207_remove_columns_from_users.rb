class RemoveColumnsFromUsers < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :name, :string
    remove_column :users, :person_id, :string
    remove_column :users, :image, :string
  end
end
