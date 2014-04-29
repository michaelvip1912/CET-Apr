class CreateCourseTotals < ActiveRecord::Migration
  def change
    create_table :course_totals do |t|
      t.string :course_encode
      t.string :course_name

      t.timestamps
    end
  end
end
