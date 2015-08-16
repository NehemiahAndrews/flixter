require 'test_helper'

class LessonsControllerTest < ActionController::TestCase
   test "show, found, signed in, enrolled" do
    lesson = FactoryGirl.create(:lesson)    
    enrollment = FactoryGirl.create(:enrollment, course_id: lesson.section.course.id)
    sign_in enrollment.user

    get :show, :id => lesson.id

    assert_response :success
  end

  test "show, found, signed in, not enrolled" do
    user = FactoryGirl.create(:user)
    sign_in user

    lesson = FactoryGirl.create(:lesson)    
    get :show, :id => lesson.id

    assert_redirected_to course_path(lesson.section.course.id)
  end


  test "show, found, not signed in" do
    lesson = FactoryGirl.create(:lesson)    
    get :show, :id => lesson.id

    assert_redirected_to new_user_session_path
  end

  test "show, not found" do
    user = FactoryGirl.create(:user)
    sign_in user

    get :show, :id => 'fake'

    assert_response :not_found
  end

end
