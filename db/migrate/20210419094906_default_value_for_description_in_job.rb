class DefaultValueForDescriptionInJob < ActiveRecord::Migration[6.1]
  def change
    change_column :jobs, :description, :string, default: ''
  end
end
