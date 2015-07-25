require 'test_helper'

class Instructor::CoursesControllerTest < ActionController::TestCase

  test "new, signed in" do
     user = FactoryGirl.create(:user)
     sign_in user

     get :new
     assert_response :success
  end

  test "new, not signed in" do
     get :new
     assert_redirected_to new_user_session_path
  end 

  test "create, signed in" do 
      user = FactoryGirl.create(:user)
      sign_in user

      assert_difference 'Course.count' do
        post :create, :course => {
          :title => 'WebDev 101',
          :description => 'The Original',
          :cost => '350.00'
        }
      end
      course = Course.last
      assert_equal course.title, 'WebDev 101'
      assert_redirected_to instructor_course_path(course)
      assert_equal 1, user.courses.count
   end

  test "create, not signed in" do
    post :create, :course => {
      :title => 'WebDev 101',
      :description => 'The Original',
      :cost => '350.00'
    }
    assert_redirected_to new_user_session_path
  end 
 
  test "create invalid" do
    user = FactoryGirl.create(:user)
    sign_in user

    assert_no_difference 'Course.count' do
      post :create, :course => {
        :title => 'WebDev 101'
      }
    end

    assert_response :unprocessable_entity
  end

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
end
