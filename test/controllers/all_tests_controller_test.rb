require 'test_helper'

class AllTestsControllerTest < ActionController::TestCase
  setup do
    @all_test = all_tests(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:all_tests)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create all_test" do
    assert_difference('AllTest.count') do
      post :create, all_test: { attachment: @all_test.attachment, begin_date: @all_test.begin_date, description: @all_test.description, end_date: @all_test.end_date, test_date: @all_test.test_date }
    end

    assert_redirected_to all_test_path(assigns(:all_test))
  end

  test "should show all_test" do
    get :show, id: @all_test
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @all_test
    assert_response :success
  end

  test "should update all_test" do
    patch :update, id: @all_test, all_test: { attachment: @all_test.attachment, begin_date: @all_test.begin_date, description: @all_test.description, end_date: @all_test.end_date, test_date: @all_test.test_date }
    assert_redirected_to all_test_path(assigns(:all_test))
  end

  test "should destroy all_test" do
    assert_difference('AllTest.count', -1) do
      delete :destroy, id: @all_test
    end

    assert_redirected_to all_tests_path
  end
end
