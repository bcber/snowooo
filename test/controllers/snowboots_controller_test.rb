require 'test_helper'

class SnowbootsControllerTest < ActionController::TestCase
  setup do
    @snowboot = snowboots(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:snowboots)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create snowboot" do
    assert_difference('Snowboot.count') do
      post :create, snowboot: {  }
    end

    assert_redirected_to snowboot_path(assigns(:snowboot))
  end

  test "should show snowboot" do
    get :show, id: @snowboot
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @snowboot
    assert_response :success
  end

  test "should update snowboot" do
    patch :update, id: @snowboot, snowboot: {  }
    assert_redirected_to snowboot_path(assigns(:snowboot))
  end

  test "should destroy snowboot" do
    assert_difference('Snowboot.count', -1) do
      delete :destroy, id: @snowboot
    end

    assert_redirected_to snowboots_path
  end
end
