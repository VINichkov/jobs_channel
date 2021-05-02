class UserAction< ActiveRecord::Migration[6.1]
  def change
    create_table :user_actions do |t|
      t.integer :action, null: false
      t.integer  :id_message, null: false
      t.integer :id_user, null: false
      t.boolean :is_bot, null: false,  default: false
      t.string :first_name
      t.string :last_name
      t.string :username
      t.string :language_code
      t.string :value
      t.references :author, polymorphic: true
      t.timestamps
    end
    add_index(:user_actions, [:action, :id_message, :id_user])
  end
end
