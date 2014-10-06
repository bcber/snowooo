require 'test_helper'

class SnowboardsControllerTest < ActionController::TestCase
  setup do
    @snowboard = snowboards(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:snowboards)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create snowboard" do
    assert_difference('Snowboard.count') do
      post :create, snowboard: {  }
    end

    assert_redirected_to snowboard_path(assigns(:snowboard))
  end

  test "should show snowboard" do
    get :show, id: @snowboard
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @snowboard
    assert_response :success
  end

  test "should update snowboard" do
    patch :update, id: @snowboard, snowboard: {  }
    assert_redirected_to snowboard_path(assigns(:snowboard))
  end

  test "should destroy snowboard" do
    assert_difference('Snowboard.count', -1) do
      delete :destroy, id: @snowboard
    end

    assert_redirected_to snowboards_path
  end
end
