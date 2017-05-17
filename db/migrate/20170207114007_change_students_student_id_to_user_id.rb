class ChangeStudentsStudentIdToUserId < ActiveRecord::Migration[5.0]
  def change
    rename_column :students, :student_id, :user_id
  end
end
