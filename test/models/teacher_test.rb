require 'test_helper'

class TeacherTest < ActiveSupport::TestCase
  setup do
    #Using setup here instead of fixtures because fixtures cause errors.
    @teacher = Teacher.new(user_name: "profbill",
                password_digest: "password",
                last_login: Time.now,
                full_name: "Professor Bill",
                screen_name: "profbill",
                icon: "apple",
                color: "red",
                email: "wtktriger@noctrl.edu",
                description: "Super user",
                powers: "Admin",
                school_id: 0)
  end
  
  test "should be valid" do
    assert @teacher.valid?
  end
end
