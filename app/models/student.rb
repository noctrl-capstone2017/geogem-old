class Student < ApplicationRecord
  #Creates the relationship of what teachers the student belongs too
    has_many :passive_relationships, class_name:  "RosterStudent",
                                     foreign_key: "student_id",
                                     dependent:   :destroy
    has_many :teachers, through: :passive_relationships, source: :teacher
    
    #Creates the relationship of what behaviors are tracked for the student
    has_many :active_relationships, class_name:  "RosterSquare",
                                     foreign_key: "student_id",
                                     dependent:   :destroy
    has_many :squares, through: :active_relationships, source: :square
end
