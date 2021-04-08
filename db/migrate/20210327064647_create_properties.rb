class CreateProperties < ActiveRecord::Migration[6.1]
  def change
    create_table :properties do |t|
      t.string :code
      t.string :value
      t.string :description

      t.timestamps
    end
  end
end
