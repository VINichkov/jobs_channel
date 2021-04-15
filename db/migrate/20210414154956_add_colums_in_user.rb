class AddColumsInUser < ActiveRecord::Migration[6.1]
  def change
    add_column :jobs, :first_name, :string
    add_column :jobs, :last_name, :string
  end
end
