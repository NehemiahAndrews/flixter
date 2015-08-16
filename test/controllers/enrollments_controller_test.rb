require 'test_helper'

class EnrollmentsControllerTest < ActionController::TestCase
  test "create, signed in" do 
      user = FactoryGirl.create(:user)
      course = FactoryGirl.create(:course)
      sign_in user

      assert_difference 'Enrollment.count' do
        post :create, :course_id => course.id, :enrollment => {
          :course_id => course.id ,
          :user_id => user.id
        }
      end
      enrollment = Enrollment.last
      assert_equal enrollment.user_id, user.id
      assert_redirected_to course_path(course)
      assert_equal 1, user.enrollments.count
   end

  test "create, not signed in" do
    user = FactoryGirl.create(:user)
    course = FactoryGirl.create(:course)    
    post :create, :course_id => course.id, :enrollment => {
      :course_id => course.id,
      :user_id => user.id
    }
    assert_redirected_to new_user_session_path
  end
end
