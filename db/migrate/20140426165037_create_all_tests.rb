class CreateAllTests < ActiveRecord::Migration
  def change
    create_table :all_tests do |t|
      t.date :test_date
      t.date :begin_date
      t.date :end_date
      t.string :description
      t.string :attachment

      t.timestamps
    end
  end
end
