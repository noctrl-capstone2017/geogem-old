class AddSuspensionToTeachers < ActiveRecord::Migration[5.0]
  def change
    add_column :teachers, :suspended, :boolean
  end
end
