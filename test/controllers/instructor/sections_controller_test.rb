require 'test_helper'

class Instructor::SectionsControllerTest < ActionController::TestCase
  test "new, signed in" do
     user = FactoryGirl.create(:user)
     sign_in user
     course = FactoryGirl.create(:course)

     get :new, :course_id => course.id
     assert_response :success
  end

  test "new, not signed in" do
     user = FactoryGirl.create(:user)
     course = FactoryGirl.create(:course)
     
     get :new, :course_id => course.id
     assert_redirected_to new_user_session_path
  end 

  test "create, signed in" do 
      user = FactoryGirl.create(:user)
      sign_in user
      course = FactoryGirl.create(:course)

      assert_difference 'Section.count' do
        post :create,:course_id => course.id, :section => {
          :title => 'Section 1'
          }
      end
      section = Section.last
      assert_equal section.title, 'Section 1'
      assert_redirected_to instructor_course_path(course)
      assert_equal 1, user.sections.count
   end

  test "create, not signed in" do
    post :create, :section => {
      :title => 'Section 1'
    }
    assert_redirected_to new_user_session_path
  end 
 
  test "create invalid" do
    user = FactoryGirl.create(:user)
    sign_in user

    assert_no_difference 'Section.count' do
      post :create, :section => {
        :title => 'WebDev 101',
        :face => 'Beautiful'
      }
    end

    assert_response :unprocessable_entity
  end
end
