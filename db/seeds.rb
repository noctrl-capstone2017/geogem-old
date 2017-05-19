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
  color = Faker::Commerce.color
  email = "example-#{n+1}@railstutorial.org"
  desc = Faker::Lorem.sentence
  pre = Faker::Address.city_suffix
  pos = Faker::Address.city_prefix
  School.create!(full_name: pre + pos + "University",
                 screen_name: "test",
                 icon: pre,
                 color: color,
                 email: email,
                 website: "www.example.edu",
                 description: desc)
    
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

# Seed the database with 10 faked Students
# They go to North Central College
10.times do |n|
  name  = Faker::Name.first_name + " " + Faker::Name.last_name
  Student.create!(  screen_name: "temp",
                    contact_info: "student contact info",
                    description: "student description",
                    icon: "bicycle",
                    color: "green",
                    session_interval: 20,
                    school_id: 1,
                    full_name: name)
end

# Two students with different school id's than the rest
2.times do |n|
  name  = Faker::Name.name
  Student.create!(  screen_name: "temp",
                    contact_info: "student contact info",
                    description: "student description",
                    icon: "bicycle",
                    color: "green",
                    session_interval: 20,
                    school_id: 2,
                    full_name: name)
end

# Seed the database with 10 faked Squares
# They are North Central College's squares
# tracking_type: 1 is duration, 2 is frequency, 3 is interval
10.times do |n|
  name  = Faker::Hipster.word + " " + Faker::Hipster.word
  Square.create!(full_name: name,
                 screen_name: "S#{n+1}",
                 tracking_type: (n%3)+1,      #1, 2, or 3
                 description: name,
                 color: "red",
                 school_id: 1)
end


#So far, there are 10 students created for North Central College.
#Put 5 of them on profbill's roster.
5.times do |n|
  RosterStudent.create!(teacher_id: 1,  #1st teach is super prof bill,
                                        #2nd is general teacher
                        student_id: n+1)
end


#Give the first student 5 squares
5.times do |n|
  RosterSquare.create!(square_id: n+1,
                        student_id: 1)
end

# Seed the database with a session between the first teacher and first student 
Session.create!(start_time: DateTime.new(2017,5,15,8,30, 0),
                end_time: DateTime.new(2017,5,15,11,30, 0),
                session_teacher: 1,
                session_student: 1)

#Seed the database with ten session events for the first session

x = DateTime.new(2017,5,15,8, 30, 0)           #Start the session at 8:30 am
roster_IDS = RosterSquare.where(student_id: 1) #roster square ids for student1

10.times do |n|
SessionEvent.create!(behavior_square_id: roster_IDS[n%5].square_id,
                    square_press_time: x,
                    duration_end_time: x + 5.0/1440,
                    session_id:1)
x = x + 16.0/1440
end

#Made this seed to debug and check events that start/end at interval endpoint
SessionEvent.create!(behavior_square_id: roster_IDS[1].square_id,
                     square_press_time: DateTime.new(2017,5,15,8,45, 0),
                     duration_end_time: DateTime.new(2017,5,15,8,48, 0),
                     session_id:1)

# Seed the database with 5 notes for the seeded Session
y = DateTime.new(2017,5,15,8, 37, 0)
5.times do |n|
SessionNote.create!(note: Faker::Hipster.sentence,
                session_id: 1, created_at: y)
y = y + 11.0/1440
end