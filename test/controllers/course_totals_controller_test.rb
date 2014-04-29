require 'test_helper'

class CourseTotalsControllerTest < ActionController::TestCase
  setup do
    @course_total = course_totals(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:course_totals)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create course_total" do
    assert_difference('CourseTotal.count') do
      post :create, course_total: { course_encode: @course_total.course_encode, course_name: @course_total.course_name }
    end

    assert_redirected_to course_total_path(assigns(:course_total))
  end

  test "should show course_total" do
    get :show, id: @course_total
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @course_total
    assert_response :success
  end

  test "should update course_total" do
    patch :update, id: @course_total, course_total: { course_encode: @course_total.course_encode, course_name: @course_total.course_name }
    assert_redirected_to course_total_path(assigns(:course_total))
  end

  test "should destroy course_total" do
    assert_difference('CourseTotal.count', -1) do
      delete :destroy, id: @course_total
    end

    assert_redirected_to course_totals_path
  end
end
