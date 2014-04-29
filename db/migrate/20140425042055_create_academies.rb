class CreateAcademies < ActiveRecord::Migration
  def change
    create_table :academies do |t|
      t.string :academy_encode
      t.string :academy_name

      t.timestamps
    end
  end
end
