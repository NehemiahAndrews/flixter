require 'test_helper'

class LessonsControllerTest < ActionController::TestCase
   test "show, found, signed in" do
    user = FactoryGirl.create(:user)
    sign_in user

    lesson = FactoryGirl.create(:lesson)    
    get :show, :id => lesson.id

    assert_response :success
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
