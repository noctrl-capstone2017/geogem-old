#Author: Taylor Spino
#If you want to add extra seeds for your own use, add them at the bottom (:
#include ux_helper.rb

stud_icons = ["bug", "car", "puzzle-piece", "flash", "futbol-o", 
            "gamepad","heart", "leaf","paper-plane","paw","star","graduation-cap"];

#Took out light blue for now because controller changes it 
#to lt blue which is not linked here
colors = ["red", "orange", "yellow", "green", "mint", "navy", "lavender", "plum", "pink"];

case Rails.env

when "development"
# Seed the database with a School
# School.find(1)
School.create!(full_name: "North Central",
               screen_name: "noctrl",
               icon: "apple",
               color: "red",
               email: "noctrl@noctrl.edu",
               website: "noctrl.edu",
               description: "It's North Central!")


#School seeds added by - Dakota B
30.times do |n|
  School.create!(full_name: Faker::University.name,
                 screen_name: "schl-#{n+2}",
                 icon: "apple",
                 color: colors.sample,
                 email: "example-#{n+1}@railstutorial.org",
                 website: "www.example.edu",
                 description: Faker::Lorem.sentence)
    
end

# Seed the database with an initial Super user profbill
# Associate him with North Central College (school_id: 1)
# Teacher.find(1)
Teacher.create!(user_name: "profbill",
                password: "password",
                password_confirmation: "password",
                last_login: Time.now,
                full_name: "Professor Bill",
                screen_name: "profbill",
                icon: "apple",
                color: "red",
                email: "wtktriger@noctrl.edu",
                description: "Super user",
                powers: "Admin",
                school_id: 1)
                
# Seed the database with a general teacher login
# We'll have them work at Noth Central College, school_id: 1
# Teacher.find(2)
Teacher.create!(user_name: "teacher",
                password: "password",
                password_confirmation: "password",
                last_login: Time.now,
                full_name: "teacher",
                screen_name: "teacher",
                icon: "apple",
                color: "green",
                email: "teacher@noctrl.edu",
                description: "General teacher login",
                powers: "Teacher",
                school_id: 1)
                
# Seed the database with a general teacher login who has admin powers
# They also work at North Central College
# Teacher.find(3)
Teacher.create!(user_name: "admin",
                password: "password",
                password_confirmation: "password",
                last_login: Time.now,
                full_name: "admin",
                screen_name: "admin",
                icon: "apple",
                color: "green",
                email: "admin@noctrl.edu",
                description: "General admin login",
                powers: "Admin",
                school_id: 1)

# Seed the database with 30 faked Students
# They go to North Central College
30.times do |n|
  first_name  = Faker::Name.first_name
  last_name = Faker::Name.last_name
  Student.create!(  screen_name: first_name.downcase[0] + last_name.downcase,
                    contact_info: "student contact info",
                    description: "student description",
                    icon: stud_icons.sample,
                    color: colors.sample,
                    session_interval: 15,
                    school_id: 1,
                    full_name: first_name + " " + last_name)
end

# Two students with different school id's than the rest
2.times do |n|
  first_name  = Faker::Name.first_name
  last_name = Faker::Name.last_name
  Student.create!(  screen_name: first_name.downcase[0] + last_name.downcase,
                    contact_info: "student contact info",
                    description: "student description",
                    icon: "bicycle",
                    color: "green",
                    session_interval: 15,
                    school_id: 2,
                    full_name: first_name + " " + last_name)
end

# Seed the database with 10 faked Squares
# They are North Central College's squares
# tracking_type: 1 is duration, 2 is frequency, 3 is interval
10.times do |n|
  name  = Faker::Lorem.word + " " + Faker::Lorem.word
  Square.create!(full_name: name,
                 screen_name: "S#{n+1}",
                 tracking_type: (n%3)+1,    #1, 2, or 3 NEED TO CHANGE THIS FOR ENUM CLASS
                 description: name,
                 color: colors.sample,
                 school_id: 1)
end


#So far, there are 30 students created for North Central College.
#Put 30 of them on profbill's roster.
30.times do |n|
  RosterStudent.create!(teacher_id: 1,  #1st teacher is super prof bill,
                                        #2nd is general teacher
                        student_id: n+1)
end


#Give the first student 5 squares
5.times do |n|
  RosterSquare.create!(square_id: n+1, #squares 1-5
                        student_id: 1)
end

#Give the third student 5 squares
5.times do |n|
  RosterSquare.create!(square_id: n+3, #squares 3-8
                        student_id: 3)
end

#------------------TWO SESSIONS WITH STUDENT 1----------------------#

# Seed the database with a session between the first teacher and first student
# Session.find(1)
Session.create!(start_time: DateTime.new(2017,5,15,8,30, 0),
                end_time: DateTime.new(2017,5,15,11,30, 0),
                session_teacher: 1,
                session_student: 1)

# Seed the database with another session between the first teacher and first student
Session.create!(start_time: DateTime.new(2017,5,22,7,50, 0),
                end_time: DateTime.new(2017,5,22,9,05, 0),
                session_teacher: 1,
                session_student: 1)

#------------------FOUR SESSIONS WITH STUDENT 3----------------------#
                
#STUDENT 3 SESSION 1
Session.create!(start_time: DateTime.new(2017,5,12,9,00, 0),
                end_time: DateTime.new(2017,5,12,12,00, 0),
                session_teacher: 1,
                session_student: 3)


#STUDENT 3 SESSION 2
Session.create!(start_time: DateTime.new(2017,5,15,9,00, 0),
                end_time: DateTime.new(2017,5,15,12,00, 0),
                session_teacher: 1,
                session_student: 3)

#STUDENT 3 SESSION 3
Session.create!(start_time: DateTime.new(2017,5,23,9,00, 0),
                end_time: DateTime.new(2017,5,23,12,00, 0),
                session_teacher: 1,
                session_student: 3)

#STUDENT 3 SESSION 4
Session.create!(start_time: DateTime.new(2017,5,27,9,00, 0),
                end_time: DateTime.new(2017,5,27,12,00, 0),
                session_teacher: 1,
                session_student: 3)

#----------------------STUDENT 1 SESSIONS--------------------------#

#Seed the database with ten session events for STUDENT 1 SESSION 1
x = DateTime.new(2017,5,15,8, 30, 0)           #Start the session at 8:30 am
roster_IDS = RosterSquare.where(student_id: 1) #roster square ids for student1

10.times do |n|
SessionEvent.create!(behavior_square_id: roster_IDS[n%5].square_id,
                    square_press_time: x,
                    duration_end_time: x + 5.0/1440,
                    session_id:1)
x = x + 16.0/1440
end

#Used to check events that start/end at interval endpoint
SessionEvent.create!(behavior_square_id: roster_IDS[1].square_id,
                      square_press_time: DateTime.new(2017,5,15,8,45, 0),
                      duration_end_time: DateTime.new(2017,5,15,8,48, 0),
                      session_id:1)

# Seed the database with 5 notes for the seeded Session
y = DateTime.new(2017,5,15,8, 37, 0)
5.times do |n|
SessionNote.create!(note: Faker::Lorem.sentence,
                session_id: 1, created_at: y)
y = y + 11.0/1440
end

#--------------------STUDENT 3 SESSIONS--------------------------#
#5/12, 5/15, 5/23, 5/27

#Seed the database with ten session events for STUDENT 1 SESSION 2
a = [ DateTime.new(2017,5,12,9,00, 0),
      DateTime.new(2017,5,15,9,00, 0),
      DateTime.new(2017,5,23,9,00, 0),
      DateTime.new(2017,5,27,9,00, 0) ]        #Start the session at 9:00 am
roster_IDS2 = RosterSquare.where(student_id: 3) #roster square ids for student1
4.times do |k|
b = a[k]
  5.times do |l|
  #for now only have events of with id = roster_IDS2[2].square_id (square 5)
  #this is for Kevin P, so your graph for SQUARE 5 should show FOUR DAYS
  #where this square occurred FIVE times
  SessionEvent.create!(behavior_square_id: roster_IDS2[2].square_id,
                      square_press_time: b,
                      duration_end_time: b + 5.0/1440,
                      session_id: (k+3) ) #session 1-2 is STUDENT 1, sessions 3-6 is STUDENT 3
  b = b + 30.0/1440
  end

end

#-----NON-TAYLOR S SEEDS. FEEL FREE TO PLANT WHATEVER YOU WANT HERE------#
# |---------------------SEEDS FOR TEST USE-------------------------------|
# Seed the database with a disposable test school and two teachers
School.create!(full_name: "South Central",
               screen_name: "soctrl",
               icon: "apple",
               color: "red",
               email: "soctrl@noctrl.edu",
               website: "soctrl.edu",
               description: "It's South Central!")
               
Teacher.create!(user_name: "TEST_teacher1",
                password: "password",
                password_confirmation: "password",
                last_login: Time.now,
                full_name: "TEST1",
                screen_name: "TEST1",
                icon: "apple",
                color: "green",
                email: "teacher@soctrl.edu",
                description: "General teacher login",
                powers: "Teacher",
                school_id: 32)
                
Teacher.create!(user_name: "TEST_teacher2",
                password: "password",
                password_confirmation: "password",
                last_login: Time.now,
                full_name: "TEST2",
                screen_name: "TEST2",
                icon: "apple",
                color: "green",
                email: "teacher@soctrl.edu",
                description: "General teacher login",
                powers: "Teacher",
                school_id: 32)

Teacher.create!(user_name: "TEST_teacherSus",
                password: "password",
                password_confirmation: "password",
                last_login: Time.now,
                full_name: "TEST2",
                screen_name: "TEST2",
                icon: "apple",
                color: "green",
                email: "teacherz@soctrl.edu",
                description: "General teacher login",
                powers: "Teacher",
                school_id: 32,
                suspended: true)
                

when "production"

# creates school Noctrl and teacher (+Super) profbill
School.create!(full_name: "North Central",
               screen_name: "noctrl",
               icon: "apple",
               color: "red",
               email: "noctrl@noctrl.edu",
               website: "noctrl.edu",
               description: "It's North Central!")
               
Teacher.create!(user_name: "profbill",
                password: "password",
                password_confirmation: "password",
                last_login: Time.now,
                full_name: "Professor Bill",
                screen_name: "profbill",
                icon: "apple",
                color: "red",
                email: "wtktriger@noctrl.edu",
                description: "Super user",
                powers: "Admin",
                school_id: 1)
end
                