class CreateProfessionals < ActiveRecord::Migration
  def change
    create_table :professionals do |t|
      t.string :professional_encode
      t.string :professional_name

      t.timestamps
    end
  end
end
