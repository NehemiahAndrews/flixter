require 'test_helper'

class Instructor::SectionsControllerTest < ActionController::TestCase
  test "new, signed in, correct user" do
     course = FactoryGirl.create(:course)
     sign_in course.user

     get :new, :course_id => course.id
     assert_response :success
  end

  test "new, signed in, incorrect user" do
     user = FactoryGirl.create(:user)
     sign_in user
     course = FactoryGirl.create(:course)
     
     get :new, :course_id => course.id
     assert_response :unauthorized
  end

  test "new, not signed in" do
     course = FactoryGirl.create(:course)
     
     get :new, :course_id => course.id
     assert_redirected_to new_user_session_path
  end 

  test "create, signed in, correct user" do 
      course = FactoryGirl.create(:course)
      sign_in course.user

      assert_difference 'Section.count' do
        post :create,:course_id => course.id, :section => {
          :title => 'Section 1'
          }
      end
      section = Section.last
      assert_equal section.title, 'Section 1'
      assert_redirected_to instructor_course_path(course)
      assert_equal 1, course.sections.count
   end

   test "create, signed in, incorrect user" do 
      user = FactoryGirl.create(:user)
      sign_in user
      course = FactoryGirl.create(:course)

      assert_no_difference 'Section.count' do
        post :create,:course_id => course.id, :section => {
          :title => 'Section 1'
          }
      end
      
      assert_response :unauthorized
   end

  test "create, not signed in" do
    course = FactoryGirl.create(:course)
    post :create, :course_id => course.id, :section => {
      :title => 'Section 1'
    }
    assert_redirected_to new_user_session_path
  end 

  test "create invalid" do
    course = FactoryGirl.create(:course)
    sign_in course.user

    assert_no_difference 'Section.count' do
      post :create, :course_id => course.id, :section => { 
        :title => ''
    }
    end

    assert_response :unprocessable_entity
  end

end
