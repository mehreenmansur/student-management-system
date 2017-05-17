class CreateSemesterCourses < ActiveRecord::Migration[5.0]
  def change
    create_table :semester_courses do |t|
      t.integer :semester_id
      t.integer :course_id

      t.timestamps
    end
  end
end
