class CreateAllTestCourses < ActiveRecord::Migration
  def change
    create_table :all_test_courses do |t|
      t.integer :all_test_id
      t.string :course_encode

      t.timestamps
    end
  end
end
