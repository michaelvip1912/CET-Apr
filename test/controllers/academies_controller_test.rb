require 'test_helper'

class AcademiesControllerTest < ActionController::TestCase
  setup do
    @academy = academies(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:academies)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create academy" do
    assert_difference('Academy.count') do
      post :create, academy: {  }
    end

    assert_redirected_to academy_path(assigns(:academy))
  end

  test "should show academy" do
    get :show, id: @academy
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @academy
    assert_response :success
  end

  test "should update academy" do
    patch :update, id: @academy, academy: {  }
    assert_redirected_to academy_path(assigns(:academy))
  end

  test "should destroy academy" do
    assert_difference('Academy.count', -1) do
      delete :destroy, id: @academy
    end

    assert_redirected_to academies_path
  end
end
