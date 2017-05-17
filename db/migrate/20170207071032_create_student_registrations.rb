class CreateStudentRegistrations < ActiveRecord::Migration[5.0]
  def change
    create_table :student_registrations do |t|
      t.integer :semester_id
      t.integer :course_id
      t.integer :student_id
      t.string :status
      t.decimal :gpa

      t.timestamps
    end
  end
end
