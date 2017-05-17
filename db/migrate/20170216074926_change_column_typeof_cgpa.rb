class ChangeColumnTypeofCgpa < ActiveRecord::Migration[5.0]
  def change
    change_column :student_registrations, :gpa, :float
  end
end
