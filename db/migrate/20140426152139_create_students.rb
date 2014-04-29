class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.string :student_no
      t.string :name
      t.string :grade
      t.string :id_number
      t.string :academy_encode
      t.string :professional_encode
      t.string :gender

      t.timestamps
    end
  end
end
