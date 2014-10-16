require 'test_helper'

class SnowbindingsControllerTest < ActionController::TestCase
  setup do
    @snowbinding = snowbindings(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:snowbindings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create snowbinding" do
    assert_difference('Snowbinding.count') do
      post :create, snowbinding: {  }
    end

    assert_redirected_to snowbinding_path(assigns(:snowbinding))
  end

  test "should show snowbinding" do
    get :show, id: @snowbinding
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @snowbinding
    assert_response :success
  end

  test "should update snowbinding" do
    patch :update, id: @snowbinding, snowbinding: {  }
    assert_redirected_to snowbinding_path(assigns(:snowbinding))
  end

  test "should destroy snowbinding" do
    assert_difference('Snowbinding.count', -1) do
      delete :destroy, id: @snowbinding
    end

    assert_redirected_to snowbindings_path
  end
end
