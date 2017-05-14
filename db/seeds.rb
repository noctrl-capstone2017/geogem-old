School.create!(full_name: "North Central",
               screen_name: "noctrl",
               icon: "apple",
               color: "red",
               email: "noctrl@noctrl.edu",
               website: "noctrl.edu",
               description: "It's North Central!")

Teacher.create!(user_name: "profbill",
                password_digest: Teacher.digest("password"),
                last_login: Time.now,
                full_name: "Professor Bill",
                screen_name: "profbill",
                icon: "apple",
                color: "red",
                email: "wtktriger@noctrl.edu",
                description: "Super user",
                powers: "Admin",
                school_id: 0)