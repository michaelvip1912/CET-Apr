class CreateSignUps < ActiveRecord::Migration
  def change
    create_table :sign_ups do |t|
      t.string :subject_1_encode
      t.string :subject_2_encode
      t.string :subject_3_encode
      t.string :subject_4_encode
      t.string :name
      t.string :gender
      t.string :student_no
      t.string :id_type
      t.string :id_number
      t.string :education_len
      t.string :education
      t.string :start_school
      t.string :grade
      t.string :academy_encode
      t.string :professional_encode
      t.string :class_name
      t.string :tel
      t.string :photo_url
      t.integer :all_test_id
      t.boolean :paid

      t.timestamps
    end
  end
end
