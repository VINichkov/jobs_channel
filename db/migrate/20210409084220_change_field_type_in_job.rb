class ChangeFieldTypeInJob < ActiveRecord::Migration[6.1]
  def up
    remove_column :jobs, :type
    remove_column :jobs, :contract
    add_column :jobs, :job_type, :integer, default: 0, null: false
    add_column :jobs, :contact, :string
  end

  def down
    remove_column :jobs, :job_type
    remove_column :jobs, :contact
    add_column :jobs, :type, :string
    add_column :jobs, :contract, :string
  end
end
