class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :encode
      t.string :name
      t.string :academy_encode
      t.string :password_digest
      t.string :remember_token

      t.timestamps
    end
  end
end
