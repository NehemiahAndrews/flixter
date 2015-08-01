require 'test_helper'

class CoursesControllerTest < ActionController::TestCase
   test "show, found" do
    user = FactoryGirl.create(:user)
    sign_in user

    course = FactoryGirl.create(:course)    
    get :show, :id => course.id

    assert_response :success
  end

  test "show, not found" do
    user = FactoryGirl.create(:user)
    sign_in user
    get :show, :id => 'fake'

    assert_response :not_found
  end

  test "index" do
    course = FactoryGirl.create(:course)
    get :index

    assert_response :ok
  end
end
