class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :email,            null: false
      t.string :user_name,        null: false
      t.string :password_digest,  null: false
      t.timestamps
    end
    add_reference :orders, :user, foreign_key: true
  end
end