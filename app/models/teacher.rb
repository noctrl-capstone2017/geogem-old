class Teacher < ApplicationRecord
  
  #Creates the relationship of what students belong to the teacher
  #author Matthew OBzera & Alex P
  has_many :active_relationships, class_name:  "RosterStudent",
                                  foreign_key: "teacher_id",
                                  dependent:   :destroy

  has_many :students, through: :active_relationships, source: :student
end
