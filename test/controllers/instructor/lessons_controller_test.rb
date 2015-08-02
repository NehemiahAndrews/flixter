require 'test_helper'

class Instructor::LessonsControllerTest < ActionController::TestCase
  test "new, signed in, correct user" do
     section = FactoryGirl.create(:section)
     sign_in section.course.user

     get :new, :section_id => section.id

     assert_response :success
  end

  test "new, not signed in" do
     section = FactoryGirl.create(:section)

     get :new, :section_id => section.id

     assert_redirected_to new_user_session_path
  end

  test "new, signed in, invalid user" do
     user = FactoryGirl.create(:user)
     sign_in user
     section = FactoryGirl.create(:section)

     get :new, :section_id => section.id

     assert_response :unauthorized
  end

   test "create, signed in, correct user" do 
      section = FactoryGirl.create(:section)
      sign_in section.course.user

      assert_difference 'Lesson.count' do
        post :create,:section_id => section.id, :lesson => {
          :title => 'Lesson 1',
          :subtitle => 'Getting Started'
          }
      end
      lesson = Lesson.last
      assert_equal lesson.title, 'Lesson 1'
      assert_redirected_to instructor_course_path(section.course)
      assert_equal 1, section.lessons.count
   end

 
  test "create, signed in, incorrect user" do 
      user = FactoryGirl.create(:user)
      sign_in user
      section = FactoryGirl.create(:section)

      assert_no_difference 'Lesson.count' do
        post :create,:section_id => section.id, :lesson => {
          :title => 'Lesson 1',
          :subtitle => 'Getting Started'
          }
      end
    
      assert_response :unauthorized    
   end


  test "create, not signed in" do
    section = FactoryGirl.create(:section)
    post :create, :section_id => section.id, :lesson => {
      :title => 'Lesson 1',
      :subtitle => 'Getting Started'
    }
    assert_redirected_to new_user_session_path
  end 



  test "create invalid" do
    section = FactoryGirl.create(:section)
    sign_in section.course.user

    assert_no_difference 'Section.count' do
      post :create, :section_id => section.id, :lesson => { 
        :title => '',
        :subtitle => ''
    }
    end

    assert_response :unprocessable_entity
  end

end
